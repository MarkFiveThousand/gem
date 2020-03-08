# The name of the target operating system.
SET(CMAKE_SYSTEM_NAME Linux)

# Which compilers to use for C and C++.
SET(CMAKE_C_COMPILER gcc)
SET(CMAKE_CXX_COMPILER g++)


# Where the target environment located.
list(APPEND CMAKE_FIND_ROOT_PATH /usr/bin)
list(REMOVE_DUPLICATES CMAKE_FIND_ROOT_PATH)

# NOTE: I found this code snippet.  It seemed like it will come in handy.  I
#       haven't played with it yet.
#
# Adjust the behavior of pkg-config.
# https://stackoverflow.com/questions/9221236/pkg-config-fails-to-find-package-under-sysroot-directory
#set(CMAKE_SYSROOT "/path/to/sysroot")
#set(ENV{PKG_CONFIG_DIR} "")
#set(ENV{PKG_CONFIG_LIBDIR} "${CMAKE_SYSROOT}/usr/lib/pkgconfig:${CMAKE_SYSROOT}/usr/share/pkgconfig")
#set(ENV{PKG_CONFIG_SYSROOT_DIR} ${CMAKE_SYSROOT})

# Adjust the default behavior of the FIND_XXX() commands: search headers and
# libraries in the target environment, search programs in the host environment.
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
