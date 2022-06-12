//
// Created by kis on 24.05.22.
//

#include <vector>

#include "World.cuh"

World::World(std::vector<Entity> entities) : size(entities.size()) {
    cudaMalloc(&g_pos, sizeof(float3) * size);
    cudaMalloc(&g_movDir, sizeof(float3) * size);
    cudaMalloc(&g_mass, sizeof(float) * size);

    std::vector<float3> buffV3;
    buffV3.resize(size);
    for (std::size_t i = 0; i < size; i++) {
        buffV3[i].x = entities[i].pos.x;
        buffV3[i].y = entities[i].pos.y;
        buffV3[i].z = entities[i].pos.z;
    }
    cudaMemcpy(g_pos, buffV3.data(), sizeof(float3) * size, cudaMemcpyHostToDevice);

    for (std::size_t i = 0; i < size; i++) {
        buffV3[i].x = entities[i].velocity.x;
        buffV3[i].y = entities[i].velocity.y;
        buffV3[i].z = entities[i].velocity.z;
    }
    cudaMemcpy(g_movDir, buffV3.data(), sizeof(float3) * size, cudaMemcpyHostToDevice);

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
    std::vector<float3> buff;
    entities.resize(size);
    buff.resize(size);

    cudaMemcpy(buff.data(), g_pos, sizeof(float3) * size, cudaMemcpyDeviceToHost);

    for (std::size_t i = 0; i < size; i++) {
        entities[i].pos.x = buff[i].x;
        entities[i].pos.y = buff[i].y;
        entities[i].pos.z = buff[i].z;
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

__device__ inline float norm(const float3 &vec) {
    return sqrtf(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z);
}

__global__ void calcAcc(std::size_t size, const float3 *pos, const float *mass, float3 *accVec, float gravConst) {
    std::size_t index = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (index < size) {
        auto calcFG = [pos, mass, gravConst, index](std::size_t i) {
            float3 dist = pos[i] - pos[index];
            float len = norm(dist);

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

__global__ void applyAcceleration(std::size_t size, const float3 *accVec, float3 *movDir, float t) {
    std::size_t index = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (index < size) {
        movDir[index] = movDir[index] + accVec[index] * t;
    }
}

__global__ void applyMovement(std::size_t size, const float3 *movDir, float3 *pos, float t) {
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
