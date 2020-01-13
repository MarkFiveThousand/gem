cmake_minimum_required(VERSION 2.8)

# See ReadMe.txt

# ============================================================================
# Useful Links:
# ============================================================================
# Commonly used cmake variables:
# http://www.cmake.org/Wiki/CMake_Useful_Variables/Logging_Useful_Variables



# =============================================================================
# Debug
# =============================================================================
SET(DEBUG_BUILD_SCRIPTS 0)


if (DEBUG_BUILD_SCRIPTS)
	# Output summary of our settings.
	MESSAGE(STATUS "================================================================================")
	MESSAGE(STATUS "CMAKE_C_FLAGS= ${CMAKE_C_FLAGS}")
	MESSAGE(STATUS "CMAKE_CXX_FLAGS = ${CMAKE_CXX_FLAGS}")
	MESSAGE(STATUS "CMAKE_CPP_FLAGS = ${CMAKE_CPP_FLAGS}")
	MESSAGE(STATUS "CMAKE_EXE_LINKER_FLAGS = ${CMAKE_EXE_LINKER_FLAGS}")
	MESSAGE(STATUS "CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX}")
	MESSAGE(STATUS "CMAKE_MAKE_PROGRAM = ${CMAKE_MAKE_PROGRAM}")

	MESSAGE(STATUS "GEM_BUILD_LEVEL = ${GEM_BUILD_LEVEL}")
	MESSAGE(STATUS "GEM_OS_HOST_BUILD = ${GEM_OS_HOST_BUILD}")

	MESSAGE(STATUS "PROJ_BIN_DIR = ${PROJ_BIN_DIR}")
	MESSAGE(STATUS "PROJ_BIN_FULLPATH = ${PROJ_BIN_FULLPATH}")
	MESSAGE(STATUS "PROJ_BUILD_CONFIG = ${PROJ_BUILD_CONFIG}")
	MESSAGE(STATUS "PROJ_BUILD_DIR = ${PROJ_BUILD_DIR}")
	MESSAGE(STATUS "PROJ_BUILD_FULLPATH = ${PROJ_BUILD_FULLPATH}")
	MESSAGE(STATUS "PROJ_DIR = ${PROJ_DIR}")
	MESSAGE(STATUS "PROJ_EXE_NAME = ${PROJ_EXE_NAME}")
	MESSAGE(STATUS "PROJ_INSTALL_DIR = ${PROJ_INSTALL_DIR}")
	MESSAGE(STATUS "PROJ_INSTALL_FULLPATH = ${PROJ_INSTALL_FULLPATH}")
	MESSAGE(STATUS "PROJ_LIB_DIR = ${PROJ_LIB_DIR}")
	MESSAGE(STATUS "PROJ_LIB_FULLPATH = ${PROJ_LIB_FULLPATH}")
	MESSAGE(STATUS "PROJ_NAME = ${PROJ_NAME}")
	MESSAGE(STATUS "PROJ_SRC_DIR = ${PROJ_SRC_DIR}")
	MESSAGE(STATUS "PROJ_TARGET_PLATFORM = ${PROJ_TARGET_PLATFORM}")
	MESSAGE(STATUS "================================================================================")
endif()



# =============================================================================
# Operating system specific settings.
# =============================================================================
# NOTE:  It's too late to set some build variables here.  For example, if you
# want to change the value of CMAKE_MAKE_PROGRAM, you must do that in the call
# to cmake using -DCMAKE_MAKE_PROGRAM=whatever.
# ---------------------------------- MINGW -----------------------------------
if ("${PROJ_TARGET_PLATFORM}" STREQUAL "GEM_OS_HOST_BUILD_MINGW")


# ---------------------------------- LINUX ---------------------------------
elseif ("${PROJ_TARGET_PLATFORM}" STREQUAL "GEM_OS_HOST_BUILD_LINUX")


else() # Client didn't properly set PROJ_TARGET_PLATFORM on the command line.
	MESSAGE(FATAL_ERROR "PROJ_TARGET_PLATFORM=${PROJ_TARGET_PLATFORM} not recognized.")
endif()





# ============================================================================
# Build the File Tree
# ============================================================================
# Executables go here.
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJ_BIN_FULLPATH})

# .a files go here.
#SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJ_LIB_FULLPATH})

# .so files go here.
#SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJ_BIN_FULLPATH})







# ============================================================================
# Project
# ============================================================================
# IMPORTANT!  To debug in Eclipse "your project name should be different from
# your executable name and different from your build folder name.
# http://www.cmake.org/Wiki/Eclipse_CDT4_Generator

PROJECT("${PROJ_EXE_NAME}")
#PROJECT("Project_${PROJ_EXE_NAME}")
# The above PROJECT() call will set the ${PROJECT_NAME} variable.



# ============================================================================
# Preprocessor, Compiler, and Linker Options
# ============================================================================
#
# NOTES:
# ------
# CFLAGS: C flags, passed during compile AND link (e.g., -O2 -std=c99)
# CXXFLAGS: C++ flags, passed during compile AND link (e.g., -O2 -std=c++98)
# CPPFLAGS: pre-processor flags, passed ONLY during compile (e.g., -DNDEBUG=1
#                                                            -Iadditional/include)
# LDFLAGS: linker flags, passed ONLY during link (e.g., -export_dynamic
#                                                 -Ladditional/libdir -llib)
#
# -Wall								Turn on many reasonable kinds of warnings. 
#                                   For further details see:
#									https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
# -Wextra							Enables some extra warning flags that are 
#									not enabled by -Wall.
# -Wfatal-errors					This option causes the compiler to abort
#									compilation on the first error occurred.
# -g								Produce debugging information.
# -fvisibility=hidden				Hide all dll symbols by default.

# ---------------------------------- COMMON ----------------------------------
ADD_DEFINITIONS(-D${GEM_BUILD_LEVEL})

# Linux and Windows only!
ADD_DEFINITIONS(-DHAVE_OPENGL)





#INCLUDE_DIRECTORIES ("/home/mhodges/projects/sdl2/sdk/incude/SDL2")
INCLUDE_DIRECTORIES ("/home/mhodges/projects/sdl2/src/SDL2-2.0.5/include")

LINK_DIRECTORIES ($PROJ_BIN_FULLPATH)	# shared libraries are here.
LINK_DIRECTORIES ($PROJ_LIB_FULLPATH)	# static libraries are here.









ADD_COMPILE_OPTIONS(-Wall -Wextra -Wfatal-errors)

# ---------------------------------- DEBUG -----------------------------------
if ("${GEM_BUILD_LEVEL}" STREQUAL "GEM_BUILD_LEVEL_DEBUG")

	ADD_COMPILE_OPTIONS(-g)
	SET(CMAKE_BUILD_TYPE Debug)

# ---------------------------------- RELEASE ---------------------------------
elseif ("${GEM_BUILD_LEVEL}" STREQUAL "GEM_BUILD_LEVEL_RELEASE")

	SET(CMAKE_BUILD_TYPE RelWithDebInfo)

# ---------------------------------- MASTER ----------------------------------
elseif ("${GEM_BUILD_LEVEL}" STREQUAL "GEM_BUILD_LEVEL_MASTER")

	SET(CMAKE_BUILD_TYPE MinSizeRel)

# --------------------------------- GOLDMASTER -------------------------------
elseif ("${GEM_BUILD_LEVEL}" STREQUAL "GEM_BUILD_LEVEL_GOLDMASTER")

	SET(CMAKE_BUILD_TYPE MinSizeRel)

else() # Client didn't properly set GEM_BUILD_LEVEL on the command line.
	MESSAGE(FATAL_ERROR "GEM_BUILD_LEVEL is not valid")
endif()






# ============================================================================
# Executable
# ============================================================================
ADD_EXECUTABLE(${PROJECT_NAME}
	testgl2.c)

# Compiler Settings

# Linker Settings
TARGET_LINK_LIBRARIES(${PROJECT_NAME} SDL2 SDL2_test)


if (DEBUG_BUILD_SCRIPTS)
	MESSAGE(STATUS "================================================================================")
	MESSAGE(STATUS "GEM_BUILD_LEVEL = ${GEM_BUILD_LEVEL}")
	MESSAGE(STATUS "CMAKE_BUILD_TYPE = ${CMAKE_BUILD_TYPE}")

	# These below are completely empty.
	#MESSAGE(STATUS "EXECUTABLE_OUTPUT_PATH= ${EXECUTABLE_OUTPUT_PATH}")
	#MESSAGE(STATUS "LIBRARY_OUTPUT_PATH= ${LIBRARY_OUTPUT_PATH}")
	#MESSAGE(STATUS "ARCHIVE_OUTPUT_DIRECTORY= ${ARCHIVE_OUTPUT_DIRECTORY}")
	#MESSAGE(STATUS "LIBRARY_OUTPUT_DIRECTORY= ${LIBRARY_OUTPUT_DIRECTORY}")
	#MESSAGE(STATUS "RUNTIME_OUTPUT_DIRECTORY= ${RUNTIME_OUTPUT_DIRECTORY}")
	MESSAGE(STATUS "================================================================================")
endif()





# ============================================================================
# Post-build Steps
# ============================================================================

if ("${GEM_OS_HOST_BUILD}" STREQUAL "GEM_OS_HOST_BUILD_MINGW")

	# Copy the required system libraries to our bin/ directory.
	# Source:
	#  http://stackoverflow.com/questions/10671916/how-to-copy-dll-files-into-the-same-folder-as-the-executable-using-cmake
	GET_FILENAME_COMPONENT( Mingw_Path ${CMAKE_CXX_COMPILER} PATH )
	ADD_CUSTOM_COMMAND(TARGET ${PROJ_NAME} POST_BUILD	# Adds a post-build event to MyTest
		COMMAND ${CMAKE_COMMAND} -E copy_if_different	# which executes "cmake - E
														# copy_if_different..."
			"${Mingw_Path}/libstdc++-6.dll"             # Source file(s)
			"${Mingw_Path}/libwinpthread-1.dll"
			"${Mingw_Path}/libgcc_s_seh-1.dll"
			${PROJ_BIN_FULLPATH})                       # Dest file path

	SET(SDK_BIN_FULLPATH "${PROJ_DIR}/sdk/bin/${PROJ_TARGET_PLATFORM}/${PROJ_BUILD_CONFIG}")
	ADD_CUSTOM_COMMAND(TARGET ${PROJ_NAME} POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E copy_if_different
			"${SDK_BIN_FULLPATH}/libSharedLib.dll"
			${PROJ_BIN_FULLPATH})

endif()







