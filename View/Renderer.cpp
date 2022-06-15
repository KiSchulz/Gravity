//
// Created by kis on 24.05.22.
//

#include "Renderer.h"

#include <chrono>

Renderer::Renderer(World &world) : world(world), flip(false) {
    sAppName = "Gravity";
}

bool Renderer::OnUserCreate() {
    simThread = std::thread{&Renderer::runSimThread, this};
    return true;
}

bool Renderer::OnUserUpdate(float dt) {
    ReadKeys();

    UpdateScreen();

    return true;
}

void Renderer::UpdateScreen() {
    Clear(olc::BLANK);

    std::stringstream text;
    text << std::fixed
         << "time: " << world.timePassed << ", "
         << "speedup: " << world.getSpeedup() << ", "
         << "step size: " << world.timeStepSize << ", "
         << "flipped: " << flip << ", "
         << "zoom: " << zoom;
    DrawString({0, 10}, text.str());

    const auto vec = world.getPosVec();
    float width = (float) ScreenHeight() / 2;
    auto first = vec[0];

    for (auto &i: vec) {
        float x = (i.x() - first.x()) * zoom + width;
        float y = width;

        if (flip) {
            y -= (i.y() - first.y()) * zoom;
        } else {
            y -= (i.z() - first.z()) * zoom;
        }
        Draw((int) x, (int) y);
    }
}

void Renderer::ReadKeys() {
    if (GetKey(olc::D).bPressed) {
        world.timeStepSize = (float) std::min(0.3, world.timeStepSize * 1.25);
    }
    if (GetKey(olc::A).bPressed) {
        world.timeStepSize = (float) std::max(0.00000001, world.timeStepSize / 1.25);
    }
    if (GetKey(olc::F).bPressed) {
        flip = !flip;
    }
    if (GetKey(olc::W).bPressed) {
        zoom *= 1.25f;
    }
    if (GetKey(olc::S).bPressed) {
        zoom /= 1.25f;
    }
}

void Renderer::runSimThread() {
    while (run) {
        world.step();
    }
}

Renderer::~Renderer() {
    run = false;
    simThread.join();
}
