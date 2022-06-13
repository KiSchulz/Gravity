//
// Created by kis on 24.05.22.
//

#include <vector>

#include "World.cuh"

World::World(std::vector<Entity> entities) : size(entities.size()) {
    cudaMalloc(&g_pos, sizeof(Vec3) * size);
    cudaMalloc(&g_movDir, sizeof(Vec3) * size);
    cudaMalloc(&g_mass, sizeof(float) * size);

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
        buff[i] = entities[i].mass;
    }
    cudaMemcpy(g_mass, buff.data(), sizeof(float) * size, cudaMemcpyHostToDevice);
}

World::~World() {
    cudaFree(g_pos);
    cudaFree(g_movDir);
    cudaFree(g_mass);
}

std::vector<Entity> World::getEntities() const {
    std::vector<Entity> entities;
    std::vector<Vec3> buff;
    entities.resize(size);
    buff.resize(size);

    cudaMemcpy(buff.data(), g_pos, sizeof(Vec3) * size, cudaMemcpyDeviceToHost);

    for (std::size_t i = 0; i < size; i++) {
        entities[i].pos = buff[i];
    }

    return entities;
}

__device__ inline float3 operator+(const float3 &lhs, const float3 &rhs) {
    return {lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z};
}

__device__ inline float3 operator-(const float3 &lhs, const float3 &rhs) {
    return {lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z};
}

__device__ inline float3 operator*(const float3 &vec, float fac) {
    return {vec.x * fac, vec.y * fac, vec.z * fac};
}

__global__ void calcAcc(std::size_t size, const Vec3 *pos, const float *mass, Vec3 *accVec, float gravConst) {
    std::size_t index = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (index < size) {
        auto calcFG = [pos, mass, gravConst, index](std::size_t i) {
            Vec3 dist = pos[i] - pos[index];
            float len = norm3df(dist.x, dist.y, dist.z);

            float fg = (gravConst * mass[index] * mass[i]) / (len * len * len);

            return dist * fg;
        };

        accVec[index] = make_float3(0, 0, 0);

        for (std::size_t i = 0; i < index; i++) {
            accVec[index] = accVec[index] + calcFG(i);
        }
        for (std::size_t i = index + 1; i < size; i++) {
            accVec[index] = accVec[index] + calcFG(i);
        }

        accVec[index] = accVec[index] * (1 / mass[index]);
    }
}

__global__ void applyAcceleration(std::size_t size, const Vec3 *accVec, Vec3 *movDir, float t) {
    std::size_t index = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (index < size) {
        movDir[index] = movDir[index] + accVec[index] * t;
    }
}

__global__ void applyMovement(std::size_t size, const Vec3 *movDir, Vec3 *pos, float t) {
    std::size_t index = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (index < size) {
        pos[index] = pos[index] + movDir[index] * t;
    }
}

void World::step() {
    std::size_t blockSize = 256;
    std::size_t numBlocks = (size + blockSize - 1) / blockSize;
    float3 *accVec;
    cudaMalloc(&accVec, size * sizeof(float3));

    calcAcc<<<numBlocks, blockSize>>>(size, g_pos, g_mass, accVec, gravityConstant);
    applyAcceleration<<<numBlocks, blockSize>>>(size, accVec, g_movDir, timeStepSize);

    cudaFree(accVec);

    applyMovement<<<numBlocks, blockSize>>>(size, g_movDir, g_pos, timeStepSize);

    timePassed += timeStepSize;

    cudaDeviceSynchronize();
}
