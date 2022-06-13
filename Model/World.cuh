//
// Created by kis on 24.05.22.
//

#ifndef GRAVITY_WORLD_CUH
#define GRAVITY_WORLD_CUH

#include <vector>

#include "Entity.h"
#include "Utility/Vec3.h"

class World {
public:
    static constexpr const float gravityConstant = 6.67408e-11; //m^3*kg^-1*s^-2
    float timeStepSize = 0.3; //s
    float timePassed = 0; //s

private:
    std::size_t size;
    Vec3* g_pos;
    Vec3* g_movDir;
    float* g_mass;

public:
    explicit World(std::vector<Entity> entities);
    ~World();

    void step();

    [[nodiscard]] std::vector<Entity> getEntities() const;
};


#endif //GRAVITY_WORLD_CUH
