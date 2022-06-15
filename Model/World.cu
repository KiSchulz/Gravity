//
// Created by kis on 24.05.22.
//

#include <vector>
#include <chrono>

#include "World.cuh"

World::World(std::vector<Entity> entities) : size(entities.size()) {
    cudaMalloc(&g_pos, sizeof(Vec3) * size);
    cudaMalloc(&g_movDir, sizeof(Vec3) * size);
    cudaMalloc(&g_mass, sizeof(float) * size);
    cudaMalloc(&g_accVec, sizeof(Vec3) * size);

    posVec.resize(size);

    std::vector<Vec3> buffV3;
    buffV3.resize(size);
    for (std::size_t i = 0; i < size; i++) {
        buffV3[i] = entities[i].pos;
    }
    cudaMemcpy(g_pos, buffV3.data(), sizeof(Vec3) * size, cudaMemcpyHostToDevice);

    for (std::size_t i = 0; i < size; i++) {
        buffV3[i] = entities[i].velocity;
    }
    cudaMemcpy(g_movDir, buffV3.data(), sizeof(Vec3) * size, cudaMemcpyHostToDevice);

    std::vector<float> buff;
    buff.resize(size);
    for (std::size_t i = 0; i < size; i++) {
        buff[i] = entities[i].mass * gravityConstant;
    }
    cudaMemcpy(g_mass, buff.data(), sizeof(float) * size, cudaMemcpyHostToDevice);
}

World::~World() {
    cudaFree(g_pos);
    cudaFree(g_movDir);
    cudaFree(g_mass);
    cudaFree(g_accVec);
}

__global__ void calcAcc1(std::size_t size, const Vec3 *pos, const float *mass, Vec3 *accVec) {
    std::size_t index = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (index < size) {
        auto calcAcc = [pos, mass, index](std::size_t i) {
            Vec3 dist = pos[i] - pos[index];
            float len = dist.norm();

            return dist * (mass[i] / (len * len * len));
        };

        for (std::size_t i = 0; i < index; i++) {
            accVec[index] += calcAcc(i);
        }
        for (std::size_t i = index + 1; i < size; i++) {
            accVec[index] += calcAcc(i);
        }
    }
}

__global__ void updatePos(std::size_t size, const Vec3 *accVec, Vec3 *movDir, Vec3 *pos, float t) {
    std::size_t index = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (index < size) {
        movDir[index] += accVec[index] * t;
        pos[index] += movDir[index] * t;
    }
}

void World::step() {
    namespace sc = std::chrono;
    using namespace sc;
    time_point start = high_resolution_clock::now();

    std::size_t blockSize = 256;
    std::size_t numBlocks = (size + blockSize - 1) / blockSize;

    cudaMemset(g_accVec, 0.0f, sizeof(Vec3) * size);
    calcAcc1<<<numBlocks, blockSize>>>(size, g_pos, g_mass, g_accVec);

    updatePos<<<numBlocks, blockSize>>>(size, g_accVec, g_movDir, g_pos, timeStepSize);

    timePassed += timeStepSize;

    cudaDeviceSynchronize();

    speedup = timeStepSize / ((double) duration_cast<nanoseconds>(high_resolution_clock::now() - start).count() / 1e9f);
}

std::vector<Vec3> World::getPosVec() const {
    cudaMemcpy((void *) posVec.data(), g_pos, sizeof(Vec3) * size, cudaMemcpyDeviceToHost);
    return posVec;
}

double World::getSpeedup() const {
    return speedup;
}
