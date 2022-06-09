//
// Created by kis on 24.05.22.
//

#include <utility>

#include "World.h"
#include "Utility/Vec3.h"

World::World(std::vector<Entity> entities) : entities(std::move(entities)) {}

void World::step() {
    timePassed += timeStepSize;

    Eigen::MatrixXf matrixX(entities.size(), entities.size());
    Eigen::MatrixXf matrixY(entities.size(), entities.size());
    Eigen::MatrixXf matrixZ(entities.size(), entities.size());

    for(std::size_t i = 0; i <entities.size(); i++){
        matrixX(i, i) = 0;
        matrixY(i, i) = 0;
        matrixZ(i, i) = 0;
    }

    Eigen::VectorXf vectorX(entities.size());
    Eigen::VectorXf vectorY(entities.size());
    Eigen::VectorXf vectorZ(entities.size());

    for (std::size_t i = 0; i < entities.size() - 1; i++) {
        for (std::size_t j = i + 1; j < entities.size(); j++) {
            Vec3 fg = calcFG(i, j);

            matrixX(i, j) = fg.x();
            matrixY(i, j) = fg.y();
            matrixZ(i, j) = fg.z();

            matrixX(j, i) = -fg.x();
            matrixY(j, i) = -fg.y();
            matrixZ(j, i) = -fg.z();
        }
    }

    for (std::size_t i = 0; i < entities.size(); i++) {
        vectorX(i) = 1;
        vectorY(i) = 1;
        vectorZ(i) = 1;
    }

    vectorX = matrixX * vectorX;
    vectorY = matrixY * vectorY;
    vectorZ = matrixZ * vectorZ;

    for (std::size_t i = 0; i < entities.size(); i++) {
        entities[i].velocity += (Vec3(vectorX(i), vectorY(i), vectorZ(i)) * timeStepSize) / entities[i].mass;
        entities[i].pos += entities[i].velocity * timeStepSize;
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
