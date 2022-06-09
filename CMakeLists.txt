cmake_minimum_required(VERSION 3.23)
project(Gravity)

set(CMAKE_CXX_STANDARD 20)

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif ()

set(CMAKE_CXX_FLAGS "-lX11 -lGL -lpthread -lpng -lstdc++fs") #flags for olcPixelGameEngine
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g -fno-omit-frame-pointer")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -march=native -mtune=native -mavx -fpermissive")
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Eigen3 3.3 REQUIRED NO_MODULE)

add_executable(Gravity main.cpp Model/World.cpp Model/World.h View/Renderer.cpp View/Renderer.h Utility/Vec3.cpp Utility/Vec3.h Model/Entity.cpp Model/Entity.h Generator/BaseGenerator.h Generator/TestingGenerator.h)
include_directories(.)
target_link_libraries(Gravity Eigen3::Eigen)
