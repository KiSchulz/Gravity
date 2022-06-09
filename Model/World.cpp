//
// Created by kis on 24.05.22.
//

#include <utility>

#include "World.h"
#include "Utility/Vec3.h"

World::World(std::vector<Entity> entities) : entities(std::move(entities)) {}

void World::step() {
    timePassed += timeStepSize;

    for(auto & entity : entities){
        entity.force = Vec3 {0,0,0};
    }

    for (std::size_t i = 0; i < entities.size() - 1; i++) {
        for(std::size_t j = i + 1; j < entities.size(); j++) {
            Vec3 fg = calcFG(i, j);
            entities[i].force += fg;
            entities[j].force -= fg;
        }
    }

    for (auto & entity : entities){
        entity.velocity += (entity.force * timeStepSize) / entity.mass;
        entity.pos += entity.velocity * timeStepSize;
    }
}

Vec3 World::calcFG(std::size_t n, std::size_t m) {
    Vec3 F = entities[m].pos - entities[n].pos;
    float dist = F.norm();

    F.normalize();
    F = F * (gravityConstant * entities[n].mass * entities[m].mass) / (dist * dist);

    return F;
}

std::vector<Entity> World::getEntities() const {
    return entities;
}

void World::removeEntities(float distance) {
    for (std::size_t i = 0; i < entities.size(); i++) {
        if (entities[i].pos.norm() > distance) {
            entities.erase(entities.begin() + i);
        }
    }
}
