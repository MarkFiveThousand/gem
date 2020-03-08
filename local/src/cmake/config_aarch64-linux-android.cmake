# Source:  https://developer.android.com/ndk/guides/cmake
# Some of the variables you can configure when using CMake with the NDK:
# ANDROID_PLATFORM, ANDROID_STL, ANDROID_PIE, ANDROID_CPP_FEATURES, 
# ANDROID_ALLOW_UNDEFINED_SYMBOLS, ANDROID_ARM_MODE, ANDROID_ARM_NEON,
# ANDROID_DISABLE_FORMAT_STRING_CHECKS.

cmake_minimum_required (VERSION 3.11)

gem_Msg ("------------ ${CMAKE_CURRENT_LIST_FILE}")

# agem_arch64-linux-android_ndk_17b_api_28_stl_libc++_abi_arm64

set (gem_platform_host	aarch64-linux-android)
set (gem_host			aarch64)
set (gem_arch			arm64)
set (ANDROID_ABI		arm64-v8a)

#set (ANDROID_LLVM_TRIPLE aarch64-none-linux-android) # Do we need this for llvm?

include ($ENV{gem_fullpath_gem}/local/src/cmake/config_android_common.cmake)

