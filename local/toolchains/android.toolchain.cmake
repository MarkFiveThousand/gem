
# =============================================================================
# This is a work in progress.  MORE SETTINGS FROM GOOGLE'S
# ANDROID.TOOLCHAIN.CMAKE still need to be integrated.
# =============================================================================

# Good Source:
# https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html#cross-compiling-for-android

# See the following link for variables that should be set:
# https://developer.android.com/ndk/guides/cmake

# Our google android.toolchain.cmake sets the following:
# ANDROID_TOOLCHAIN
# ANDROID_ABI
# ANDROID_PLATFORM
# ANDROID_STL
# ANDROID_PIE
# ANDROID_CPP_FEATURES
# ANDROID_ALLOW_UNDEFINED_SYMBOLS
# ANDROID_ARM_MODE
# ANDROID_ARM_NEON
# ANDROID_DISABLE_NO_EXECUTE
# ANDROID_DISABLE_RELRO
# ANDROID_DISABLE_FORMAT_STRING_CHECKS
# ANDROID_CCACHE


# Standard cross-compiling stuff.
set(ANDROID TRUE)
set(CMAKE_SYSTEM_NAME Android)
set(CMAKE_SYSTEM_VERSION 1)	# Inhibit all of CMake's own NDK handling code.

set(CMAKE_ANDROID_ARCH_ABI ${ANDROID_ABI})

# See: https://cmake.org/cmake/help/latest/variable/CMAKE_ANDROID_STL_TYPE.html
# This may need to change with llvm.
set(CMAKE_ANDROID_STL_TYPE c++_static)


# Which compilers to use for C and C++.
#set(CMAKE_C_COMPILER gcc)
#set(CMAKE_CXX_COMPILER g++)

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
