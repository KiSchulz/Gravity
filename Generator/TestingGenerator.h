//
// Created by kis on 24.05.22.
//

#ifndef GRAVITY_TESTINGGENERATOR_H
#define GRAVITY_TESTINGGENERATOR_H

#include <vector>
#include <random>
#include <cmath>

#include "BaseGenerator.h"

struct TestingGenerator : public BaseGenerator {
    World generate() override {
        const std::size_t numEntities = 1000;
        Entity center{{0, 0, 0}, {0, 0, 0}, 1e12};
        std::vector<Entity> entities = {center};
        entities.reserve(numEntities);

        std::random_device device;
        std::mt19937 rng(device());
        std::uniform_real_distribution<float> posDistribution(-200, 200);
        std::uniform_real_distribution<float> dirDistribution(-1, 1);
        std::uniform_real_distribution<float> massDistribution(1, 1e8);

        for (std::size_t i = 0; i < numEntities; i++) {
            Vec3 pos{posDistribution(rng), posDistribution(rng), posDistribution(rng)};

            Vec3 relPos = center.pos - pos;

            float x = dirDistribution(rng);
            float y = dirDistribution(rng);
            float z = (-x * relPos.x() - y * relPos.y()) / relPos.z();

            Vec3 dir{x, y, z};
            dir.normalize();
            dir = dir * (std::sqrt((World::gravityConstant * center.mass) / relPos.norm()));

            float mass = massDistribution(rng);

            entities.emplace_back(pos, dir, mass);
        }

        return World{entities};
    }

    ~TestingGenerator() override = default;
};

#endif //GRAVITY_TESTINGGENERATOR_H
