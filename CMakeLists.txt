cmake_minimum_required(VERSION 3.23)
project(Gravity LANGUAGES CXX CUDA)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CUDA_STANDARD 17)

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif ()

set(CMAKE_CXX_FLAGS "-lX11 -lGL -lpthread -lpng -lstdc++fs") #flags for olcPixelGameEngine
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g -fno-omit-frame-pointer")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -march=native -mtune=native -mavx")
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(CUDA)
find_package(Eigen3 3.3 REQUIRED NO_MODULES)

add_executable(Gravity main.cpp Model/World.cu View/Renderer.cpp Utility/Vec3.cpp Model/Entity.cpp)
include_directories(. Model View Utility Generator)
target_link_libraries(Gravity Eigen3::Eigen)
