# Gravity
__________________
## Description
__________________
A simple n-body simulation using cuda.

## Dependencies
_________________
There are three dependencies.
1. Eigen
2. Cuda
3. olcPixelGameEngine

On arch-based systems the following commands can be used to install the first two dependencies.
```bash
pacman -S eigen cuda-tools
```
The last dependency is a submodule which can be cloned later when compiling.

## Compilation
_______________
First clone the repository. Next use the following commands:
```bash
cd Gravity
```
Initialize the olcPixelGameEngine folder.
```bash
git submodule init
git submodule update
```
```bash
mkdir build
cd build
cmake ..
make all
```

## Usage
__________________
To change the system that is simulated either modify one of the existing Generators, which can be found in the folder with the same name, or write your own by writing a class which implements the BaseGenerator interface. Next swap in your class in main. The TestingGenerator creates a "stable" system and is the default one. To actually use the SolarSystem generator one would have to change the zoom member variable in Renderer.h to 1e-10 and the timeStepSize in World.cuh to 3600 which is one hour.

### Controls
| Key | Effect|
|-----|------|
|  W  | zoom in|
|  S  | zoom out|
|  A  | slow the simulation down|
|  D  | speed up the simulation|
|  F  | flip the y and z axis|
