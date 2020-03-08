#  ___________                           __________
# /\   _______\                         /\   ______\
# \ \  \______/_     ___   ____ ____ ___\ \  \_____/_     ___   ___ ___  ______   ____    ___
#  \ \  \ /\__  \  /'___`\/\   V    V   \\ \_______  \  /'   `\/\  \\  \/\   __\/' ._`\ /'___`\
#   \ \  \\/__\  \/\  ___/\ \  \/\  \/\  \\/_______\  \/\  \\  \ \  \\  \ \  \ /\  \__//\  ___/
#    \ \__________\ \____\ \ \__\ \__\ \__\ /\_________\ \_____/\ \______\ \__\\ \____/\ \____\
#     \/__________/\/____/  \/__/\/__/\/__/ \/_________/\/____/  \/______/\/__/ \/___/  \/____/


# POSITION_INDEPENDENT_CODE
# CMAKE_POSITION_INDEPENDENT_CODE

# CMAKE_SOURCE_DIR & CMAKE_BINARY_DIR variables inside a toolchain file is
# typically undesirable. The toolchain file is used in contexts where these
# variables have different values when used in different places (e.g. as part
# of a call to try_compile()). In most cases, where there is a need to evaluate
# paths inside a toolchain file, the more appropriate variable to use would be
# CMAKE_CURRENT_LIST_DIR, since it always has an unambiguous, predictable value.

cmake_minimum_required (VERSION 3.11)

include ($ENV{gem_fullpath_gem}/local/src/cmake/cmake_utils_pre.cmake)

macro (gem_UserSetVars)

	# Assume no other settings have been made yet.
	set (gem_stl_version	libc++)
	set (${gem_project_name}_VERSION_MAJOR	 0)
	set (${gem_project_name}_VERSION_MINOR	 1)

endmacro()

# =============================================================================
#                                       Main
# =============================================================================
macro(Main)

	gem_UserSetVars()

	include ($ENV{gem_fullpath_gem}/local/src/cmake/config_${gem_triple}.cmake)

	project (${gem_project_name}  CXX)

	gem_DebugDumpVars()

	# =========================================================================
	# Executable
	# =========================================================================
	# Source files
	add_executable (${gem_project_name}
		main.cpp)

	include ($ENV{gem_fullpath_gem}/local/src/cmake/cmake_utils_post.cmake)

	# =========================================================================
	# Windows System Library Dependencies
	# =========================================================================
	if (MINGW)

		# Where are the mingw dlls located?
		if (${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")

			get_filename_component (gem_fullpath_mingw_dlls ${CMAKE_CXX_COMPILER} PATH)

		else()	# Cross compiling on Linux

			set (gem_fullpath_mingw_dlls  /usr/x86_64-w64-mingw32/sys-root/mingw/bin)

		endif()

		set (CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS
			${gem_fullpath_mingw_dlls}/libstdc++-6.dll
			${gem_fullpath_mingw_dlls}/libgcc_s_seh-1.dll
			${gem_fullpath_mingw_dlls}/libwinpthread-1.dll)

		include (InstallRequiredSystemLibraries)

	endif()


	# =========================================================================
	# Build
	# =========================================================================
	# Copy MinGW dependency .dlls to build directory upon successful build.
	if (MINGW)

		foreach (gem_fileName ${CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS})

			add_custom_command(
				TARGET  ${gem_project_name}
				POST_BUILD
				COMMAND  ${CMAKE_COMMAND}
					ARGS -E copy  ${gem_fileName}  ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

		endforeach()

	endif()


	# =========================================================================
	# Install
	# =========================================================================
	if (CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS)

		install (
			PROGRAMS	${CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS}
			DESTINATION	bin
			COMPONENT	System)

	endif()
	
	install	(
		TARGETS		${gem_project_name}
		DESTINATION	bin)
	

	# =========================================================================
	#                                      CPack
	# =========================================================================
	include (InstallRequiredSystemLibraries)
	set (CPACK_PACKAGE_VERSION_MAJOR  "${${gem_project_name}_VERSION_MAJOR}")
	set (CPACK_PACKAGE_VERSION_MINOR  "${${gem_project_name}_VERSION_MINOR}")

	include (CPack)

endmacro()

Main()


