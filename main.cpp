#define OLC_PGE_APPLICATION

#include "Generator/TestingGenerator.h"
#include "Model/World.cuh"
#include "View/Renderer.h"

int main() {
   TestingGenerator t;
   World world{t.generate()};
   Renderer renderer(world);
   if(renderer.Construct(1024, 1024, 1, 1))
       renderer.Start();


    return 0;
}
