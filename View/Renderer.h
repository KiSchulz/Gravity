//
// Created by kis on 24.05.22.
//

#ifndef GRAVITY_RENDERER_H
#define GRAVITY_RENDERER_H

#include <vector>
#include <cstdint>

#include "olcPixelGameEngine/olcPixelGameEngine.h"
#include "Model/World.h"

class Renderer : public olc::PixelGameEngine {
    World& world;
    bool flip;
public:
    explicit Renderer (World& world);

    bool OnUserCreate() override;
    bool OnUserUpdate(float dt) override;

    void UpdateWorld();

    void ReadKeys();

    void UpdateScreen(float dt);
};


#endif //GRAVITY_RENDERER_H
