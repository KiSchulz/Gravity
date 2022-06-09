//
// Created by kis on 24.05.22.
//

#include "Entity.h"

#include <utility>

Entity::Entity(Vec3 pos, Vec3 velocity, float mass) : pos(std::move(pos)), velocity(std::move(velocity)), mass(mass) {
}
