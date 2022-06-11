# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.23

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/kis/server/Projekte/Gravity

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/kis/server/Projekte/Gravity/cmake-build-release-clang

# Include any dependencies generated for this target.
include CMakeFiles/Gravity.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/Gravity.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/Gravity.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Gravity.dir/flags.make

CMakeFiles/Gravity.dir/main.cpp.o: CMakeFiles/Gravity.dir/flags.make
CMakeFiles/Gravity.dir/main.cpp.o: ../main.cpp
CMakeFiles/Gravity.dir/main.cpp.o: CMakeFiles/Gravity.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/kis/server/Projekte/Gravity/cmake-build-release-clang/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/Gravity.dir/main.cpp.o"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/Gravity.dir/main.cpp.o -MF CMakeFiles/Gravity.dir/main.cpp.o.d -o CMakeFiles/Gravity.dir/main.cpp.o -c /home/kis/server/Projekte/Gravity/main.cpp

CMakeFiles/Gravity.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Gravity.dir/main.cpp.i"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kis/server/Projekte/Gravity/main.cpp > CMakeFiles/Gravity.dir/main.cpp.i

CMakeFiles/Gravity.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Gravity.dir/main.cpp.s"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kis/server/Projekte/Gravity/main.cpp -o CMakeFiles/Gravity.dir/main.cpp.s

CMakeFiles/Gravity.dir/Model/World.cu.o: CMakeFiles/Gravity.dir/flags.make
CMakeFiles/Gravity.dir/Model/World.cu.o: ../Model/World.cu
CMakeFiles/Gravity.dir/Model/World.cu.o: CMakeFiles/Gravity.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/kis/server/Projekte/Gravity/cmake-build-release-clang/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CUDA object CMakeFiles/Gravity.dir/Model/World.cu.o"
	/opt/cuda/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -MD -MT CMakeFiles/Gravity.dir/Model/World.cu.o -MF CMakeFiles/Gravity.dir/Model/World.cu.o.d -x cu -c /home/kis/server/Projekte/Gravity/Model/World.cu -o CMakeFiles/Gravity.dir/Model/World.cu.o

CMakeFiles/Gravity.dir/Model/World.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/Gravity.dir/Model/World.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/Gravity.dir/Model/World.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/Gravity.dir/Model/World.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/Gravity.dir/View/Renderer.cpp.o: CMakeFiles/Gravity.dir/flags.make
CMakeFiles/Gravity.dir/View/Renderer.cpp.o: ../View/Renderer.cpp
CMakeFiles/Gravity.dir/View/Renderer.cpp.o: CMakeFiles/Gravity.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/kis/server/Projekte/Gravity/cmake-build-release-clang/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/Gravity.dir/View/Renderer.cpp.o"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/Gravity.dir/View/Renderer.cpp.o -MF CMakeFiles/Gravity.dir/View/Renderer.cpp.o.d -o CMakeFiles/Gravity.dir/View/Renderer.cpp.o -c /home/kis/server/Projekte/Gravity/View/Renderer.cpp

CMakeFiles/Gravity.dir/View/Renderer.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Gravity.dir/View/Renderer.cpp.i"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kis/server/Projekte/Gravity/View/Renderer.cpp > CMakeFiles/Gravity.dir/View/Renderer.cpp.i

CMakeFiles/Gravity.dir/View/Renderer.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Gravity.dir/View/Renderer.cpp.s"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kis/server/Projekte/Gravity/View/Renderer.cpp -o CMakeFiles/Gravity.dir/View/Renderer.cpp.s

CMakeFiles/Gravity.dir/Utility/Vec3.cpp.o: CMakeFiles/Gravity.dir/flags.make
CMakeFiles/Gravity.dir/Utility/Vec3.cpp.o: ../Utility/Vec3.cpp
CMakeFiles/Gravity.dir/Utility/Vec3.cpp.o: CMakeFiles/Gravity.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/kis/server/Projekte/Gravity/cmake-build-release-clang/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/Gravity.dir/Utility/Vec3.cpp.o"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/Gravity.dir/Utility/Vec3.cpp.o -MF CMakeFiles/Gravity.dir/Utility/Vec3.cpp.o.d -o CMakeFiles/Gravity.dir/Utility/Vec3.cpp.o -c /home/kis/server/Projekte/Gravity/Utility/Vec3.cpp

CMakeFiles/Gravity.dir/Utility/Vec3.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Gravity.dir/Utility/Vec3.cpp.i"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kis/server/Projekte/Gravity/Utility/Vec3.cpp > CMakeFiles/Gravity.dir/Utility/Vec3.cpp.i

CMakeFiles/Gravity.dir/Utility/Vec3.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Gravity.dir/Utility/Vec3.cpp.s"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kis/server/Projekte/Gravity/Utility/Vec3.cpp -o CMakeFiles/Gravity.dir/Utility/Vec3.cpp.s

CMakeFiles/Gravity.dir/Model/Entity.cpp.o: CMakeFiles/Gravity.dir/flags.make
CMakeFiles/Gravity.dir/Model/Entity.cpp.o: ../Model/Entity.cpp
CMakeFiles/Gravity.dir/Model/Entity.cpp.o: CMakeFiles/Gravity.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/kis/server/Projekte/Gravity/cmake-build-release-clang/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/Gravity.dir/Model/Entity.cpp.o"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/Gravity.dir/Model/Entity.cpp.o -MF CMakeFiles/Gravity.dir/Model/Entity.cpp.o.d -o CMakeFiles/Gravity.dir/Model/Entity.cpp.o -c /home/kis/server/Projekte/Gravity/Model/Entity.cpp

CMakeFiles/Gravity.dir/Model/Entity.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Gravity.dir/Model/Entity.cpp.i"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kis/server/Projekte/Gravity/Model/Entity.cpp > CMakeFiles/Gravity.dir/Model/Entity.cpp.i

CMakeFiles/Gravity.dir/Model/Entity.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Gravity.dir/Model/Entity.cpp.s"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kis/server/Projekte/Gravity/Model/Entity.cpp -o CMakeFiles/Gravity.dir/Model/Entity.cpp.s

# Object files for target Gravity
Gravity_OBJECTS = \
"CMakeFiles/Gravity.dir/main.cpp.o" \
"CMakeFiles/Gravity.dir/Model/World.cu.o" \
"CMakeFiles/Gravity.dir/View/Renderer.cpp.o" \
"CMakeFiles/Gravity.dir/Utility/Vec3.cpp.o" \
"CMakeFiles/Gravity.dir/Model/Entity.cpp.o"

# External object files for target Gravity
Gravity_EXTERNAL_OBJECTS =

Gravity: CMakeFiles/Gravity.dir/main.cpp.o
Gravity: CMakeFiles/Gravity.dir/Model/World.cu.o
Gravity: CMakeFiles/Gravity.dir/View/Renderer.cpp.o
Gravity: CMakeFiles/Gravity.dir/Utility/Vec3.cpp.o
Gravity: CMakeFiles/Gravity.dir/Model/Entity.cpp.o
Gravity: CMakeFiles/Gravity.dir/build.make
Gravity: CMakeFiles/Gravity.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/kis/server/Projekte/Gravity/cmake-build-release-clang/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Linking CXX executable Gravity"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Gravity.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Gravity.dir/build: Gravity
.PHONY : CMakeFiles/Gravity.dir/build

CMakeFiles/Gravity.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/Gravity.dir/cmake_clean.cmake
.PHONY : CMakeFiles/Gravity.dir/clean

CMakeFiles/Gravity.dir/depend:
	cd /home/kis/server/Projekte/Gravity/cmake-build-release-clang && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kis/server/Projekte/Gravity /home/kis/server/Projekte/Gravity /home/kis/server/Projekte/Gravity/cmake-build-release-clang /home/kis/server/Projekte/Gravity/cmake-build-release-clang /home/kis/server/Projekte/Gravity/cmake-build-release-clang/CMakeFiles/Gravity.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/Gravity.dir/depend

