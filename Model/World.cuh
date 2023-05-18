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
    static constexpr float gravityConstant = 6.67408e-11; //m^3*kg^-1*s^-2
    static constexpr float timeStepSize = 1; //60*60*24; //s e.g. 0.3f //s

private:
    std::size_t size;
    Vec3* g_pos = nullptr;
    Vec3* g_movDir = nullptr;
    Vec3 *g_accVec = nullptr;

    float* g_mass = nullptr;    // G * m

    long timePassed = 0; //steps

public:
    explicit World(std::vector<Entity> entities);
    ~World();

    void step();

    [[nodiscard]] std::vector<Vec3> getPosVec() const;
    [[nodiscard]] std::vector<Vec3> getMovDirVec() const;
    [[nodiscard]] std::vector<float> getMassVec() const;
    [[nodiscard]] double getTimePassed() const;
};


#endif //GRAVITY_WORLD_CUH
