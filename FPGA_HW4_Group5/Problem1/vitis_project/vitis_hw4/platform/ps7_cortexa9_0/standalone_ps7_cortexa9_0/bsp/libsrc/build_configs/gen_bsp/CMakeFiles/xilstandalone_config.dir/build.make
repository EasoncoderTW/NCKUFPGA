# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.24

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

# Produce verbose output by default.
VERBOSE = 1

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
CMAKE_COMMAND = /tools/Xilinx/Vitis/2023.2/tps/lnx64/cmake-3.24.2/bin/cmake

# The command to remove a file.
RM = /tools/Xilinx/Vitis/2023.2/tps/lnx64/cmake-3.24.2/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/yoyo/work/Vitisproject/vitis_hw4/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/yoyo/work/Vitisproject/vitis_hw4/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp

# Utility rule file for xilstandalone_config.

# Include any custom commands dependencies for this target.
include CMakeFiles/xilstandalone_config.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/xilstandalone_config.dir/progress.make

CMakeFiles/xilstandalone_config:
	lopper -O /home/yoyo/work/Vitisproject/vitis_hw4/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/standalone/src /home/yoyo/work/Vitisproject/vitis_hw4/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/hw_artifacts/ps7_cortexa9_0_baremetal.dts -- baremetal_bspconfig_xlnx ps7_cortexa9_0 /tools/Xilinx/Vitis/2023.2/data/embeddedsw/lib/bsp/standalone_v9_0/src

xilstandalone_config: CMakeFiles/xilstandalone_config
xilstandalone_config: CMakeFiles/xilstandalone_config.dir/build.make
.PHONY : xilstandalone_config

# Rule to build all files generated by this target.
CMakeFiles/xilstandalone_config.dir/build: xilstandalone_config
.PHONY : CMakeFiles/xilstandalone_config.dir/build

CMakeFiles/xilstandalone_config.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/xilstandalone_config.dir/cmake_clean.cmake
.PHONY : CMakeFiles/xilstandalone_config.dir/clean

CMakeFiles/xilstandalone_config.dir/depend:
	cd /home/yoyo/work/Vitisproject/vitis_hw4/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/yoyo/work/Vitisproject/vitis_hw4/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp /home/yoyo/work/Vitisproject/vitis_hw4/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp /home/yoyo/work/Vitisproject/vitis_hw4/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp /home/yoyo/work/Vitisproject/vitis_hw4/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp /home/yoyo/work/Vitisproject/vitis_hw4/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles/xilstandalone_config.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/xilstandalone_config.dir/depend

