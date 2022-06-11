//
// Created by kis on 24.05.22.
//

#ifndef GRAVITY_ENTITY_H
#define GRAVITY_ENTITY_H

#include "Utility/Vec3.h"

struct Entity {
    Vec3 pos; //m
    Vec3 velocity; //m*s^-1
    float mass; //kg
};


#endif //GRAVITY_ENTITY_H
