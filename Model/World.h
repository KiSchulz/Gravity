//
// Created by kis on 24.05.22.
//

#ifndef GRAVITY_WORLD_H
#define GRAVITY_WORLD_H

#include <vector>

#include "Entity.h"
#include "Utility/Vec3.h"

class World {
public:
    static constexpr const float gravityConstant = 6.67408e-11; //m^3*kg^-1*s^-2
    float timeStepSize = 0.3; //s
    float timePassed = 0; //s

private:
    std::vector<Entity> entities;

    Vec3 calcFG(std::size_t n, std::size_t m);

public:
    explicit World(std::vector<Entity> entities);

    void step();
    void removeEntities(float distance);

    [[nodiscard]] std::vector<Entity> getEntities() const;
};


#endif //GRAVITY_WORLD_H
