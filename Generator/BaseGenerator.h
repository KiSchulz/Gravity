//
// Created by kis on 24.05.22.
//

#ifndef GRAVITY_BASEGENERATOR_H
#define GRAVITY_BASEGENERATOR_H

#include "Model/World.cuh"

class BaseGenerator {
public:
    virtual World generate() = 0;

    virtual ~BaseGenerator() = default;
};

#endif //GRAVITY_BASEGENERATOR_H
