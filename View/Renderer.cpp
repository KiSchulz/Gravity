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
    std::this_thread::sleep_for(std::chrono::milliseconds((int) std::max(0.0f, (16.6f - dt))));

    ReadKeys();
    UpdateScreen();

    return true;
}

void Renderer::UpdateScreen() {
    Clear(olc::BLANK);

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

    std::stringstream text;
    text << std::fixed
         << "time: " << world.getTimePassed() << ", "
         << "speedup: " << speedUp << ", "
         << "step size: " << World::timeStepSize << ", "
         << "flipped: " << flip << ", "
         << "zoom: " << zoom;
    DrawString({0, 10}, text.str());
}

void Renderer::ReadKeys() {
    if (GetKey(olc::D).bPressed) {
        delay = std::max(0, delay - 1);
    }
    if (GetKey(olc::A).bPressed) {
        delay++;
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
    namespace sc = std::chrono;
    using namespace sc;
    while (run) {
        time_point start = high_resolution_clock::now();

        std::this_thread::sleep_for(std::chrono::milliseconds(delay));

        world.step();

        speedUp = (World::timeStepSize * 1e9f) /
                  (float) duration_cast<nanoseconds>(high_resolution_clock::now() - start).count();
    }
}

Renderer::~Renderer() {
    run = false;
    simThread.join();
}
