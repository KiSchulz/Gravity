//
// Created by kis on 24.05.22.
//

#ifndef GRAVITY_RENDERER_H
#define GRAVITY_RENDERER_H

#include <vector>
#include <cstdint>
#include <thread>

#include "olcPixelGameEngine/olcPixelGameEngine.h"
#include "Model/World.cuh"

class Renderer : public olc::PixelGameEngine {
    std::thread simThread;
    bool run = true;

    World &world;
    bool flip;
    float zoom = 1.0f;
    float speedUp = 0;
    int delay = 0;

    void runSimThread();

public:
    explicit Renderer(World &world);
    ~Renderer() override;

    bool OnUserCreate() override;

    bool OnUserUpdate(float dt) override;

    void ReadKeys();

    void UpdateScreen();
};


#endif //GRAVITY_RENDERER_H
