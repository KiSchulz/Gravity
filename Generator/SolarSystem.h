//
// Created by kis on 15.06.22.
//

#ifndef GRAVITY_SOLARSYSTEM_H
#define GRAVITY_SOLARSYSTEM_H

#include <vector>

#include "BaseGenerator.h"

struct SolarSystem : public BaseGenerator {
    World generate() override {
        Entity sun = {{0.0, 0.0, 0.0}, {0.0, 0.0, 0.0}, 1.989e30}; // a star similar to the sun
        Entity mercury = {{57.909e9, 0.0, 0.0}, {0.0, 47.36e3, 0.0}, 0.33011e24}; // a planet similar to mercury
        Entity venus = {{108.209e9, 0.0, 0.0}, {0.0, 35.02e3, 0.0}, 4.8675e24}; // a planet similar to venus
        Entity earth = {{149.596e9, 0.0, 0.0}, {0.0, 29.78e3, 0.0}, 5.9724e24}; // a planet similar to earth
        Entity mars = {{227.923e9, 0.0, 0.0}, {0.0, 24.07e3, 0.0}, 0.64171e24}; // a planet similar to mars
        Entity jupiter = {{778.570e9, 0.0, 0.0}, {0.0, 13e3, 0.0}, 1898.19e24}; // a planet similar to jupiter
        Entity saturn = {{1433.529e9, 0.0, 0.0}, {0.0, 9.68e3, 0.0}, 568.34e24}; // a planet similar to saturn
        Entity uranus = {{2872.463e9, 0.0, 0.0}, {0.0, 6.80e3, 0.0}, 86.813e24}; // a planet similar to uranus
        Entity neptune = {{4495.060e9, 0.0, 0.0}, {0.0, 5.43e3, 0.0}, 102.413e24}; // a planet similar to neptune

        std::vector<Entity> vec{sun, mercury, venus, earth, mars, jupiter, saturn, uranus, neptune};

        return World{vec};
    }

    ~SolarSystem() override = default;
};

#endif //GRAVITY_SOLARSYSTEM_H
