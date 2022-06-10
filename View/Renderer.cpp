//
// Created by kis on 24.05.22.
//

#include "Renderer.h"

#include <chrono>

Renderer::Renderer(World &world) : world(world), flip(false) {
    sAppName = "Gravity";
}

bool Renderer::OnUserCreate() {
    return true;
}

bool Renderer::OnUserUpdate(float dt) {
    ReadKeys();

    UpdateWorld();

    UpdateScreen(dt);

    return true;
}

void Renderer::UpdateScreen(float dt) {
    Clear(olc::BLANK);

    std::stringstream text;
    text << std::fixed
         << "time: " << world.timePassed << ", "
         << "speedup: " << world.timeStepSize * (1 / dt) << ", "
         << "step size: " << world.timeStepSize << ", "
         << "flipped: " << flip;
    DrawString({0, 10}, text.str());

    for (auto el: world.getEntities()) {
        if (flip) {
            Draw(el.pos.x + ScreenWidth() / 2, ScreenHeight() / 2 - el.pos.y);
        } else {
            Draw(el.pos.x + ScreenWidth() / 2, ScreenHeight() / 2 - el.pos.z);
        }
    }
}

void Renderer::ReadKeys() {
    if (GetKey(olc::UP).bPressed) {
        world.timeStepSize *= 1.25;
    }
    if (GetKey(olc::DOWN).bPressed) {
        world.timeStepSize /= 1.25;
    }
    if (GetKey(olc::Z).bPressed) {
        flip = !flip;
    }
}

void Renderer::UpdateWorld() {
    world.step();
}
