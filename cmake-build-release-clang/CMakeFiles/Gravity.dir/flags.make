# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.23

# compile CUDA with /opt/cuda/bin/nvcc
# compile CXX with /usr/bin/clang++
CUDA_DEFINES = 

CUDA_INCLUDES = -I/home/kis/server/Projekte/Gravity/. -I/opt/cuda/include

CUDA_FLAGS = -O3 -DNDEBUG --generate-code=arch=compute_52,code=[compute_52,sm_52] -std=c++17

CXX_DEFINES = 

CXX_INCLUDES = -I/home/kis/server/Projekte/Gravity/. -I/opt/cuda/include

CXX_FLAGS = -lX11 -lGL -lpthread -lpng -lstdc++fs -O3 -march=native -mtune=native -mavx -std=gnu++20
