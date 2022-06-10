//
// Created by kis on 24.05.22.
//

#include <utility>
#include <stdexcept>
#include <iostream>

#include "World.h"

World::World(std::vector<Entity> entities) : entities(std::move(entities)) {
    int err;
    std::size_t local, global;
    cl_platform_id platformId;
    cl_device_id deviceId;
    cl_context context;
    cl_command_queue commandQueue;
    cl_program program;
    cl_kernel kernel;
    cl_mem input, output;

    const int count = 4;
    float data[count] = {1.0, 2.0, 3.0, 4.0};

    const char *programSource = "\n" \
  "__kernel void square(                                                  \n" \
  "   __global float* input,                                              \n" \
  "   __global float* output,                                             \n" \
  "   const unsigned int count)                                           \n" \
  "{                                                                      \n" \
  "   int i = get_global_id(0);                                           \n" \
  "   if(i < count)                                                       \n" \
  "       output[i] = input[i] * input[i];                                \n" \
  "}                                                                      \n" \
  "\n";

    for (float i: data) {
        std::cout << i << "\n";
    }

    err = clGetPlatformIDs(1, &platformId, nullptr);
    if (err != CL_SUCCESS) {
        throw std::runtime_error{"Failed to get platform id!\n"};
    }

    err = clGetDeviceIDs(platformId, CL_DEVICE_TYPE_GPU, 1, &deviceId, nullptr);
    if (err != CL_SUCCESS) {
        throw std::runtime_error{"Failed to create device group!\n"};
    }

    context = clCreateContext(nullptr, 1, &deviceId, nullptr, nullptr, &err);
    if (err != CL_SUCCESS) {
        throw std::runtime_error{"Failed to create compute context!\n"};
    }

    commandQueue = clCreateCommandQueue(context, deviceId, 0, &err);
    if (err != CL_SUCCESS) {
        throw std::runtime_error{"Failed to create command queue!\n"};
    }

    program = clCreateProgramWithSource(context, 1, (const char **) &programSource, nullptr, &err);
    if (err != CL_SUCCESS) {
        throw std::runtime_error{"Failed to create program!\n"};
    }

    err = clBuildProgram(program, 0, nullptr, nullptr, nullptr, nullptr);
    if (err != CL_SUCCESS) {
        std::size_t len;
        char buffer[2048];
        clGetProgramBuildInfo(program, deviceId, CL_PROGRAM_BUILD_LOG, sizeof(buffer), buffer, &len);
        throw std::runtime_error{buffer};
    }

    kernel = clCreateKernel(program, "square", &err);
    if (err != CL_SUCCESS) {
        throw std::runtime_error{"Failed to create compute kernel!\n"};
    }

    input = clCreateBuffer(context, CL_MEM_READ_ONLY, sizeof(float) * count, nullptr, nullptr);
    output = clCreateBuffer(context, CL_MEM_WRITE_ONLY, sizeof(float) * count, nullptr, nullptr);
    if (!input || !output) {
        throw std::runtime_error{"Failed to allocate device memory!\n"};
    }

    err = clEnqueueWriteBuffer(commandQueue, input, CL_TRUE, 0, sizeof(float) * count, data, 0, nullptr, nullptr);
    if (err != CL_SUCCESS) {
        throw std::runtime_error{"Failed to write to source array!\n"};
    }

    err = 0;
    err = clSetKernelArg(kernel, 0, sizeof(cl_mem), &input);
    err |= clSetKernelArg(kernel, 1, sizeof(cl_mem), &output);
    err |= clSetKernelArg(kernel, 2, sizeof(unsigned int), &count);
    if (err != CL_SUCCESS) {
        throw std::runtime_error{"Failed to set kernel arguments!\n"};
    }

    err = clGetKernelWorkGroupInfo(kernel, deviceId, CL_KERNEL_WORK_GROUP_SIZE, sizeof(local), &local, nullptr);
    if (err != CL_SUCCESS) {
        throw std::runtime_error{"Failed to retrieve kernel work group ingo!\n"};
    }

    global = local;
    err = clEnqueueNDRangeKernel(commandQueue, kernel, 1, nullptr, &global, &local, 0, nullptr, nullptr);
    if (err != CL_SUCCESS) {
        throw std::runtime_error{"Failed to execute the kernel!\n"};
    }

    clFinish(commandQueue);

    err = clEnqueueReadBuffer(commandQueue, output, CL_TRUE, 0, sizeof(float) * count, data, 0, nullptr, nullptr);
    if (err != CL_SUCCESS) {
        throw std::runtime_error{"Failed to read output to array!\n"};
    }

    for (float i: data) {
        std::cout << i << "\n";
    }

    clReleaseMemObject(input);
    clReleaseMemObject(output);
    clReleaseProgram(program);
    clReleaseKernel(kernel);
    clReleaseCommandQueue(commandQueue);
    clReleaseContext(context);

    exit(-1);
}

void World::step() {

}

std::vector<Entity> World::getEntities() const {
    return entities;
}
