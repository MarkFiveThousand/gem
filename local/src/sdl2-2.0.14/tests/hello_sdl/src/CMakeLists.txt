# =============================================================================
# Assumptions
# =============================================================================
# As per Cmake instructions, CMake must run from the build folder.  The full
# path to the build folder is stored in PROJECT_BINARY_DIR.  In order for this
# script to work, the file structure/path to the build directory must conform
# to the following:
#
# <Full path to parent of project>/<project name>/build/<OS & architecture>/<build type>

# For example, if CMake is run in the following folder:
#
# /home/mhodges/projects/sdl2_apps/hello_sdl/build/MINGW64_x86_64/Debug
#
# PROJECT_BINARY_DIR = /home/mhodges/projects/sdl2_apps/hello_sdl/build/MINGW64_x86_64/Debug
# PROJECT_ROOT_DIR = /home/mhodges/projects/sdl2_apps/hello_sdl       Because it preceeds "/build/".
# PROJECT_NAME = hello_sdl
# CONFIG_SUFFIX = MINGW64_x86_64/Debug
# CMAKE_BUILD_TYPE = Debug

# =============================================================================
# Environment Variable Dependencies
# =============================================================================
# GEM_OS_HOST_BUILD
# GEM_DIR_LOCAL
# SDL_DIR

# ============================================================================
# Useful Links:
# ============================================================================
# Commonly used cmake variables:
# http://www.cmake.org/Wiki/CMake_Useful_Variables/Logging_Useful_Variables



# =============================================================================
# Initialization
# =============================================================================
cmake_minimum_required(VERSION 3.6)

set(DEBUG_BUILD_SCRIPTS 1)

# Configuration settings that must be done before project() declaration.
# Do we need to set CMAKE_INTDIR or CMAKE_CFG_INTDIR?
SET(CMAKE_CONFIGURATION_TYPES ${CMAKE_BUILD_TYPE})
#message(STATUS "CMAKE_CONFIGURATION_TYPES = ${CMAKE_CONFIGURATION_TYPES}")



# =============================================================================
# Validate Dependencies
# =============================================================================
if(NOT DEFINED ENV{GEM_OS_HOST_BUILD})
    message(FATAL_ERROR "ERROR: GEM_OS_HOST_BUILD environment variable must be defined")
elseif(NOT DEFINED ENV{GEM_DIR_LOCAL})
    message(FATAL_ERROR "ERROR: GEM_DIR_LOCAL environment variable must be defined")
elseif(NOT DEFINED ENV{SDL_DIR})
    message(FATAL_ERROR "ERROR: SDL_DIR environment variable must be defined")
endif()


# =============================================================================
# Directory structure
# =============================================================================
# <Full path to parent of project>/<project name>/build/<OS & architecture>/<build type>
# Given:  C:/msys64/home/mhodges/projects/sdl2_apps/hello_sdl/build/MINGW64_x86_64/Debug
#
# PROJECT_ROOT_DIR=C:/msys64/home/mhodges/projects/sdl2_apps/hello_sdl
# PROJECT_NAME=hello_sdl
get_filename_component(PROJECT_ROOT_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
get_filename_component(PROJECT_NAME ${PROJECT_ROOT_DIR} NAME)


# =============================================================================
# Project
# =============================================================================
project("${PROJECT_NAME}")


# =============================================================================
# More directory structure
# =============================================================================
# CONFIG_SUFFIX=MINGW64_x86_64/Debug
string(LENGTH ${PROJECT_ROOT_DIR} CONFIG_SUFFIX_INDEX)
math(EXPR CONFIG_SUFFIX_INDEX "${CONFIG_SUFFIX_INDEX}+7")     # Move past "/build/" (+7 characters)
string(SUBSTRING ${PROJECT_BINARY_DIR} ${CONFIG_SUFFIX_INDEX} -1 CONFIG_SUFFIX)

string(CONCAT PROJECT_BIN_DIR ${PROJECT_ROOT_DIR} "/bin/" ${CONFIG_SUFFIX})
string(CONCAT PROJECT_LIB_DIR ${PROJECT_ROOT_DIR} "/lib/" ${CONFIG_SUFFIX})
string(CONCAT PROJECT_BUILD_DIR ${PROJECT_ROOT_DIR} "/build/" ${CONFIG_SUFFIX})
string(CONCAT PROJECT_INSTALL_DIR ${PROJECT_ROOT_DIR} "/bin/" ${CONFIG_SUFFIX})

# CMAKE_INSTALL_PREFIX is prepended onto all install directories.  It defaults
# to /usr/local on UNIX and C:/Program Files (x86)/${PROJECT_NAME} on Windows.
set(CMAKE_INSTALL_PREFIX ${PROJECT_INSTALL_DIR})


# ============================================================================
# Build the File Tree
# ============================================================================
#
# What does EXECUTABLE_OUTPUT_PATH do?

# Executables go here.
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY $PROJECT_BIN_DIR)

# .a files go here.
#set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY $PROJECT_LIB_DIR)

# .so files go here.
#set(CMAKE_LIBRARY_OUTPUT_DIRECTORY $PROJECT_BIN_DIR)
# What is CMAKE_LIBRARY_OUTPUT_PATH?




# =============================================================================
# Configuration
# =============================================================================
# CMAKE_BUILD_TYPE
get_filename_component(CMAKE_BUILD_TYPE ${PROJECT_BINARY_DIR} NAME)

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
	add_compile_options(-g)
elseif (CMAKE_BUILD_TYPE STREQUAL "Release")
elseif (CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
elseif (CMAKE_BUILD_TYPE STREQUAL "MinSizeRel")
else()
	message(FATAL_ERROR "CMAKE_BUILD_TYPE cannot be determined.")
	message(FATAL_ERROR "CMAKE_BUILD_TYPE cannot be determined.")
endif()

add_definitions(-D${CMAKE_BUILD_TYPE})





if (DEBUG_BUILD_SCRIPTS)
	# Output summary of our settings.
	message(STATUS "================================================================================")
	message(STATUS "PROJECT_NAME = ${PROJECT_NAME}")
	message(STATUS "PROJECT_ROOT_DIR = ${PROJECT_ROOT_DIR}")
	message(STATUS "PROJECT_SOURCE_DIR = ${PROJECT_SOURCE_DIR}")
	message(STATUS "PROJECT_BINARY_DIR = ${PROJECT_BINARY_DIR}")
	message(STATUS "PROJECT_BIN_DIR = ${PROJECT_BIN_DIR}")
	message(STATUS "PROJECT_LIB_DIR = ${PROJECT_LIB_DIR}")
	message(STATUS "PROJECT_BUILD_DIR = ${PROJECT_BUILD_DIR}")
	message(STATUS "PROJECT_INSTALL_DIR = ${PROJECT_INSTALL_DIR}")
	message(STATUS "CONFIG_SUFFIX = ${CONFIG_SUFFIX}")
	message(STATUS "CMAKE_MAKE_PROGRAM = ${CMAKE_MAKE_PROGRAM}")
	message(STATUS "CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX}")
	message(STATUS "CMAKE_BUILD_TYPE = ${CMAKE_BUILD_TYPE}")
	message(STATUS "CMAKE_SYSTEM_NAME = ${CMAKE_SYSTEM_NAME}")
	message(STATUS "================================================================================")
endif()







# ============================================================================
# Compile Settings
# ============================================================================
if ("$ENV{GEM_OS_HOST_BUILD}" STREQUAL "GEM_OS_HOST_BUILD_MINGW" OR "$ENV{GEM_OS_HOST_BUILD}" STREQUAL "GEM_OS_HOST_BUILD_LINUX")
	add_definitions(-DHAVE_OPENGL)
endif()

# Source files
file(GLOB PROJ_SOURCE_FILES ${PROJECT_SOURCE_DIR}/*.c)
add_executable(${PROJECT_NAME} ${PROJ_SOURCE_FILES})
#add_executable(${PROJECT_NAME} testgl2.c)
# For the testgl2.c sample.
target_include_directories (${PROJECT_NAME} SYSTEM PRIVATE "$ENV{SDL_DIR}/include")


# Include directories
target_include_directories (${PROJECT_NAME} SYSTEM PRIVATE "$ENV{GEM_DIR_LOCAL}/include/SDL2")

# Compile flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wl,--no-undefined -Wall -Wextra -Wfatal-errors")
if ("$ENV{GEM_OS_HOST_BUILD}" STREQUAL "GEM_OS_HOST_BUILD_MINGW")
	set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} -static-libgcc -static -lpthread)
endif()


# ============================================================================
# Linker Settings
# ============================================================================
# Static link SDL
add_library(SDL2 STATIC IMPORTED)
set_property(TARGET SDL2 PROPERTY IMPORTED_LOCATION $ENV{GEM_DIR_LOCAL}/lib/libSDL2.a)
add_library(SDL2main STATIC IMPORTED)
set_property(TARGET SDL2main PROPERTY IMPORTED_LOCATION $ENV{GEM_DIR_LOCAL}/lib/libSDL2main.a)
set(Static_Link_Libs ${Static_Link_Libs} SDL2 SDL2main m)

if ("$ENV{GEM_OS_HOST_BUILD}" STREQUAL "GEM_OS_HOST_BUILD_MINGW")
	# Windows libraries
	set(Static_Link_Libs mingw32 ${Static_Link_Libs} dinput8 dxguid dxerr8 user32 gdi32 winmm imm32 ole32 oleaut32 shell32 version uuid)
	# Suppress the console window
	set_property(TARGET ${PROJECT_NAME} PROPERTY WIN32_EXECUTABLE true)
elseif("$ENV{GEM_OS_HOST_BUILD}" STREQUAL "GEM_OS_HOST_BUILD_LINUX")
	set(Static_Link_Libs ${Static_Link_Libs} dl pthread)
endif()

# This is specific to SDL2_test
add_library(SDL2_test STATIC IMPORTED)
set_property(TARGET SDL2_test PROPERTY IMPORTED_LOCATION $ENV{GEM_DIR_LOCAL}/lib/libSDL2_test.a)
set(Static_Link_Libs ${Static_Link_Libs} SDL2_test)

target_link_libraries(${PROJECT_NAME} ${Static_Link_Libs})





# ============================================================================
# PKG-CONFIG
# ============================================================================
# See http://stackoverflow.com/questions/3792327/cmake-sdl-config
# for how to use config-sdl to get the correct flags automatically.

# Usage: /c/msys64/home/mhodges/projects/sdl2/sdk/bin/MINGW64_x86_64/Debug/sdl2-config [--prefix[=DIR]] [--exec-prefix[=DIR]] [--version] [--cflags] [--libs] [--static-libs]

#/c/msys64/home/mhodges/projects/sdl2/sdk/bin/MINGW64_x86_64/Debug/sdl2-config --libs
#/c/msys64/home/mhodges/projects/sdl2/sdk/bin/MINGW64_x86_64/Debug/sdl2-config --cflags

# Source: https://github.com/libSDL2pp/libSDL2pp/issues/66
#find_package(PkgConfig REQUIRED)
#if (PkgConfig_FOUND)
#	message(STATUS "PkgConfig_FOUND = true")
#else()
#	message(FATAL_ERROR "ERROR: Failed to find pkg-config.")
#endif()

#TODO: Install sdl2 via pacman and hide the one we built to verify that this works.

#pkg_search_module(SDL2 REQUIRED sdl2)
#include_directories(${SDL2_INCLUDE_DIRS})
#target_link_libraries(${PROJECT_NAME} ${SDL2_LIBRARIES})






