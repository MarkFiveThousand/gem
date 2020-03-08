cmake_minimum_required(VERSION 3.11)

gem_Msg("------------ ${CMAKE_CURRENT_LIST_FILE}")

# Common Build Settings
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


# Define common directories.
set(gem_path_suffix		${gem_platform_host}${gem_platform_host_details_suffix}/${CMAKE_BUILD_TYPE})
set(gem_fullpath_build	${CMAKE_CURRENT_BINARY_DIR})
set(gem_fullpath_src	${CMAKE_SOURCE_DIR})

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${gem_fullpath_build}/bin)	# Executables (.exe and .dll) go here.
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${gem_fullpath_build}/bin)	# .so files go here.
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${gem_fullpath_build}/lib)	# .a files go here.


	# Define common build flags.
#	if [ ${PROJECT_IS_CPLUSPLUS} == 1 ]; then
#		export CXXFLAGS="${CXXFLAGS} -fexceptions -frtti"
#		export LDFLAGS="${LDFLAGS} -lc++_shared"
#	fi
