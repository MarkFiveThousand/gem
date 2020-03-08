#  ___________                           __________
# /\   _______\                         /\   ______\
# \ \  \______/_     ___   ____ ____ ___\ \  \_____/_     ___   ___ ___  ______   ____    ___
#  \ \  \ /\__  \  /'___`\/\   V    V   \\ \_______  \  /'   `\/\  \\  \/\   __\/' ._`\ /'___`\
#   \ \  \\/__\  \/\  ___/\ \  \/\  \/\  \\/_______\  \/\  \\  \ \  \\  \ \  \ /\  \__//\  ___/
#    \ \__________\ \____\ \ \__\ \__\ \__\ /\_________\ \_____/\ \______\ \__\\ \____/\ \____\
#     \/__________/\/____/  \/__/\/__/\/__/ \/_________/\/____/  \/______/\/__/ \/___/  \/____/


# *FIX: Need to set CMAKE_CXX_COMPILER_TARGET for clang to specify the target
# platform to build for.


# The name of the host operating system.
set(CMAKE_SYSTEM_NAME Windows)

# Where the target environment is located.
if(${CMAKE_HOST_SYSTEM_NAME} MATCHES "MINGW64_NT" OR	# CMake was installed using pacman.
	${CMAKE_HOST_SYSTEM_NAME} MATCHES "Windows")		# CMake installed under Windows file system.
	# Windows shell.
	set(gem_fullpath_mingw_sysroot /mingw64/bin)
else()	# Cross compiling for MinGW in Linux shell.
	set(gem_fullpath_mingw_sysroot /usr/x86_64-w64-mingw32)
endif()
list(APPEND CMAKE_FIND_ROOT_PATH ${gem_fullpath_mingw_sysroot})
list(REMOVE_DUPLICATES CMAKE_FIND_ROOT_PATH)

#gem_ExitMsg("gem_fullpath_mingw_sysroot=${gem_fullpath_mingw_sysroot}")

# Which tools to use for C and C++.
set(CMAKE_C_COMPILER x86_64-w64-mingw32-gcc)
set(CMAKE_CXX_COMPILER x86_64-w64-mingw32-g++)
if(${CMAKE_HOST_SYSTEM_NAME} MATCHES "MINGW64_NT" OR	# CMake was installed using pacman.
	${CMAKE_HOST_SYSTEM_NAME} MATCHES "Windows")		# CMake installed under Windows file system.
	# Windows shell.
	set(CMAKE_RC_COMPILER windres)
else()	# Cross compiling for MinGW in Linux shell.
	set(CMAKE_RC_COMPILER x86_64-w64-mingw32-windres)
endif()
set(CMAKE_AR ar)

# NOTE: I found this code snippet.  It seemed like it will come in handy.  I
#       haven't played with it yet.
#
# Adjust the behavior of pkg-config.
# https://stackoverflow.com/questions/9221236/pkg-config-fails-to-find-package-under-sysroot-directory
#set(CMAKE_SYSROOT "/path/to/sysroot")
#PKG_CONFIG_SYSROOT_DIR
#set(ENV{PKG_CONFIG_DIR} "")
#set(ENV{PKG_CONFIG_LIBDIR} "${CMAKE_SYSROOT}/usr/lib/pkgconfig:${CMAKE_SYSROOT}/usr/share/pkgconfig")
#set(ENV{PKG_CONFIG_SYSROOT_DIR} ${CMAKE_SYSROOT})

# Adjust the default behavior of the FIND_XXX() commands: search headers and
# libraries in the target environment, search programs in the host environment.
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
