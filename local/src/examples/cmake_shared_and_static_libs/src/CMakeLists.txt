# =============================================================================
# Overview
# =============================================================================
#
# This CMake file retrieves project settings from the project's file path.  It
# imposes the following requirements on the placement of the project within a
# defined directory structure.
#
# <Full path to parent of project>/<executable name>/build/<target platform>/<build type>
#
# For example, if CMake is run in the following folder:
#
# ~/projects/HelloWorld/build/Linux/Debug
#
# ... the following variables will be set:
#
# PROJECT_NAME          = ProjectName_HelloWorld
# PROJECT_ROOT_DIR      = ~/projects/HelloWorld
# PROJECT_SOURCE_DIR    = ~/projects/HelloWorld/src
# PROJECT_BINARY_DIR    = ~/projects/HelloWorld/build/Linux/Debug
# PROJECT_BUILD_BIN_DIR = ~/projects/HelloWorld/build/Linux/Debug/bin
# PROJECT_BUILD_LIB_DIR = ~/projects/HelloWorld/build/Linux/Debug/lib
# PROJECT_CONFIG_SUFFIX = Linux/Debug
# PROJECT_TARGET_PLATFORM  = Linux
# ANDROID_NATIVE_API_LEVEL = 
# ANDROID_ABI           = 
# CMAKE_MAKE_PROGRAM    = /bin/make
# CMAKE_INSTALL_PREFIX  = ~/projects/HelloWorld/install/Linux/Debug
# CMAKE_BUILD_TYPE      = Debug
#
# NOTE: Android projects will look more like the following example:
#
# ~/projects/HelloWorld/build/Android/api_23_abi_arm64-v8a/Debug
#
# Where <target platform> includes the api and abi values.  The api value is
# currently hard coded to expect a two-digit number.


# =============================================================================
# Early Initialization & Project Declaration
# =============================================================================
cmake_minimum_required(VERSION 3.6)

# PROJECT_ROOT_DIR
get_filename_component(PROJECT_ROOT_DIR ${CMAKE_SOURCE_DIR} DIRECTORY)

# PROJECT_EXECUTABLE_NAME
get_filename_component(PROJECT_EXECUTABLE_NAME ${PROJECT_ROOT_DIR} NAME)

# PROJECT_NAME
string(CONCAT PROJECT_NAME ProjectName_${PROJECT_EXECUTABLE_NAME})

project("${PROJECT_NAME}")

set(DEBUG_BUILD_SCRIPTS 1)


# =============================================================================
# Configure bin/ and lib/ Build Directories
# =============================================================================
# Map generated files to bin/ and lib/.
# What does EXECUTABLE_OUTPUT_PATH do?
# What is CMAKE_LIBRARY_OUTPUT_PATH?

# PROJECT_CONFIG_SUFFIX
string(LENGTH ${PROJECT_ROOT_DIR} PROJECT_CONFIG_SUFFIX_INDEX)
math(EXPR PROJECT_CONFIG_SUFFIX_INDEX "${PROJECT_CONFIG_SUFFIX_INDEX}+7")     # Move past "/build/" (+7 characters)
string(SUBSTRING ${CMAKE_CURRENT_BINARY_DIR} ${PROJECT_CONFIG_SUFFIX_INDEX} -1 PROJECT_CONFIG_SUFFIX)

# PROJECT_BUILD_BIN_DIR
string(CONCAT PROJECT_BUILD_BIN_DIR ${PROJECT_ROOT_DIR} "/build/" ${PROJECT_CONFIG_SUFFIX}/bin/)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BUILD_BIN_DIR})	# Executables (.exe and .dll) go here.
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BUILD_BIN_DIR})	# .so files go here.

# PROJECT_BUILD_LIB_DIR
# NOTE: CMAKE_ARCHIVE_OUTPUT_DIRECTORY is created during cmake for MinGW, but *not*
# for Linux and Android.  Why?
string(CONCAT PROJECT_BUILD_LIB_DIR ${PROJECT_ROOT_DIR} "/build/" ${PROJECT_CONFIG_SUFFIX}/lib/)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BUILD_LIB_DIR})	# .a files go here.


# =============================================================================
# Configuration-Specific Settings
# =============================================================================

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
	add_compile_options(-g)
elseif (CMAKE_BUILD_TYPE STREQUAL "Release")
elseif (CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
elseif (CMAKE_BUILD_TYPE STREQUAL "MinSizeRel")
else()
	message(FATAL_ERROR "CMAKE_BUILD_TYPE cannot be determined.")
endif()

add_definitions(-D${CMAKE_BUILD_TYPE})


# ============================================================================
# Compile Settings
# ============================================================================
# CFLAGS: C flags, passed during compile AND link (e.g., -O2 -std=c99)
# CXXFLAGS: C++ flags, passed during compile AND link (e.g., -O2 -std=c++98)
# CPPFLAGS: pre-processor flags, passed ONLY during compile (e.g., -DNDEBUG=1
#                                                            -Iadditional/include)
# -Wall								Turn on many reasonable kinds of warnings. 
#                                   For further details see:
#									https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
# -Wextra							Enables some extra warning flags that are 
#									not enabled by -Wall.
# -Wfatal-errors					This option causes the compiler to abort
#									compilation on the first error occurred.
# -g								Produce debugging information.
# -fvisibility=hidden				Hide all dll symbols by default.



# ============================================================================
# Shared Library
# ============================================================================
add_library(SharedLib SHARED
	SharedLib.cpp)

# Preprocessor Options
target_compile_definitions(SharedLib PUBLIC SO_BUILDING)

# Compiler Options
target_compile_options(SharedLib PUBLIC -fvisibility=hidden)



# ============================================================================
# Static Library
# ============================================================================
add_library(StaticLib STATIC
	StaticLib.cpp)

# Preprocessor Options
#target_compile_definitions(StaticLib PUBLIC ${CPP_FLAGS})
# Compiler Options
#target_compile_options(StaticLib PUBLIC ${CXX_FLAGS})



# ============================================================================
# Executable
# ============================================================================
# Source files
add_executable(${PROJECT_NAME} main.cpp)

# Set the name of the executable.  Otherwise it will be ${PROJECT_NAME}.
set_property(TARGET ${PROJECT_NAME} PROPERTY OUTPUT_NAME ${PROJECT_EXECUTABLE_NAME})

# include_directories ("${PROJECT_SOURCE_DIR}/includes")
# include_directories ("${CMAKE_CURRENT_SOURCE_DIR}/includes")

# Compile flags
# More infor here: https://stackoverflow.com/questions/33829152/for-cmake-can-you-modify-the-release-debug-compiler-flags-with-add-compiler-fl
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wl,--no-undefined -Wall -Wextra -Wfatal-errors")
add_compile_options(-Wall -Wextra -Wfatal-errors)

# *FIX!!!!!!!!!!!!!!!!!
# Instead of set(CMAKE_CXX_FLAGS...) use the newer add_compile_options(-std=c++0x)
# Starting with CMake 3.3 you can also make this flag only apply to a specific
# language (e.g. only C or C++) using the strange generator expressions syntax:
# add_compile_options($<$<COMPILE_LANGUAGE:CXX>:-std=c++14> $<$<COMPILE_LANGUAGE:C>:-std=c99>)


# The below settings are causing these errors:
#
# /usr/x86_64-w64-mingw32/sys-root/mingw/lib/../lib/libmingw32.a(lib64_libmingw32_a-crt0_c.o):(.text.startup+0x2e): undefined reference to `WinMain'
# collect2: error: ld returned 1 exit status
# /bin/sh: -static-libgcc: command not found
# /bin/sh: -static: command not found
# /bin/sh: -lpthread: command not found
#
#if ("${PROJECT_TARGET_PLATFORM}" STREQUAL "MinGW")
#	set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} -static-libgcc -static -lpthread)
#endif()

# Linker Settings
target_link_libraries(${PROJECT_NAME} SharedLib)
target_link_libraries(${PROJECT_NAME} StaticLib)




# ============================================================================
# Linker Settings
# ============================================================================
# LDFLAGS: linker flags, passed ONLY during link (e.g., -export_dynamic
#                                                 -Ladditional/libdir -llib)

if ("${PROJECT_TARGET_PLATFORM}" STREQUAL "MinGW")
	set(Static_Link_Libs mingw32 ${Static_Link_Libs} )					# Windows libraries
	set_property(TARGET ${PROJECT_NAME} PROPERTY WIN32_EXECUTABLE true)	# Suppress the console window

elseif("${PROJECT_TARGET_PLATFORM}" STREQUAL "Linux")
	set(Static_Link_Libs ${Static_Link_Libs} )
endif()

target_link_libraries(${PROJECT_NAME} ${Static_Link_Libs})



# ============================================================================
# Configure Install Settings
# ============================================================================
# NOTES:
# Executables are treated as RUNTIME targets.  Static libraries are always
# treated as ARCHIVE targets.  For non-DLL platforms shared libraries are
# treated as LIBRARY targets.  For DLL platforms the DLL part of a shared
# library is treated as a RUNTIME target and the corresponding import library
# is treated as an ARCHIVE target.

# CMAKE_INSTALL_PREFIX
string(CONCAT CMAKE_INSTALL_PREFIX ${PROJECT_ROOT_DIR} "/install/" ${PROJECT_CONFIG_SUFFIX})

# Link shared libs relative to the executable "$ORIGIN".
set_target_properties(${PROJECT_NAME} PROPERTIES
                      INSTALL_RPATH "\$ORIGIN")

# The above works, but not this. Why?
#set(CMAKE_INSTALL_RPATH "\$ORIGIN")

# Install the executable.
install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION bin)

# We need to specify both RUNTIME and LIBRARY because a shared library is a
# RUNTIME on Windows (DLL) and a LIBRARY on Linux.
install(TARGETS SharedLib RUNTIME DESTINATION bin LIBRARY DESTINATION bin)


# =============================================================================
# Debug Output
# =============================================================================
if (DEBUG_BUILD_SCRIPTS)
	# Output summary of our settings.
	message(STATUS "================================================================================")
	message(STATUS "PROJECT_NAME            = ${PROJECT_NAME}")
	message(STATUS "PROJECT_ROOT_DIR        = ${PROJECT_ROOT_DIR}")
	message(STATUS "PROJECT_SOURCE_DIR      = ${PROJECT_SOURCE_DIR}")
	message(STATUS "PROJECT_BINARY_DIR      = ${PROJECT_BINARY_DIR}")
	message(STATUS "PROJECT_BUILD_BIN_DIR   = ${PROJECT_BUILD_BIN_DIR}")
	message(STATUS "PROJECT_BUILD_LIB_DIR   = ${PROJECT_BUILD_LIB_DIR}")
	message(STATUS "PROJECT_CONFIG_SUFFIX   = ${PROJECT_CONFIG_SUFFIX}")
	message(STATUS "PROJECT_TARGET_PLATFORM = ${PROJECT_TARGET_PLATFORM}")
	message(STATUS "ANDROID_NATIVE_API_LEVEL= ${ANDROID_NATIVE_API_LEVEL}")
	message(STATUS "ANDROID_ABI             = ${ANDROID_ABI}")
	message(STATUS "ANDROID_TOOLCHAIN_NAME  = ${ANDROID_TOOLCHAIN_NAME}")
	message(STATUS "CMAKE_MAKE_PROGRAM      = ${CMAKE_MAKE_PROGRAM}")
	message(STATUS "CMAKE_INSTALL_PREFIX    = ${CMAKE_INSTALL_PREFIX}")
	message(STATUS "CMAKE_BUILD_TYPE        = ${CMAKE_BUILD_TYPE}")
	message(STATUS "CMAKE_TOOLCHAIN_FILE    = ${CMAKE_TOOLCHAIN_FILE}")
	message(STATUS "CMAKE_SYSTEM_NAME       = ${CMAKE_SYSTEM_NAME}")
	message(STATUS "================================================================================")
endif()


