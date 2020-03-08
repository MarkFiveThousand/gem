#  ___________                           __________
# /\   _______\                         /\   ______\
# \ \  \______/_     ___   ____ ____ ___\ \  \_____/_     ___   ___ ___  ______   ____    ___
#  \ \  \ /\__  \  /'___`\/\   V    V   \\ \_______  \  /'   `\/\  \\  \/\   __\/' ._`\ /'___`\
#   \ \  \\/__\  \/\  ___/\ \  \/\  \/\  \\/_______\  \/\  \\  \ \  \\  \ \  \ /\  \__//\  ___/
#    \ \__________\ \____\ \ \__\ \__\ \__\ /\_________\ \_____/\ \______\ \__\\ \____/\ \____\
#     \/__________/\/____/  \/__/\/__/\/__/ \/_________/\/____/  \/______/\/__/ \/___/  \/____/


# Source:  https://developer.android.com/ndk/guides/cmake
# Some of the variables you can configure when using CMake with the NDK:
# ANDROID_PLATFORM, ANDROID_STL, ANDROID_PIE, ANDROID_CPP_FEATURES, 
# ANDROID_ALLOW_UNDEFINED_SYMBOLS, ANDROID_ARM_MODE, ANDROID_ARM_NEON,
# ANDROID_DISABLE_FORMAT_STRING_CHECKS.

cmake_minimum_required (VERSION 3.11)

gem_Msg ("------------ ${CMAKE_CURRENT_LIST_FILE}")


#set (gem_platform_host_details_suffix _ndk_${NDK_VERSION}_api_${ANDROID_NATIVE_API_LEVEL}_stl_${STL_VERSION}_abi_${gem_arch})
set (gem_platform_host_details_suffix _api_${ANDROID_NATIVE_API_LEVEL}_abi_${gem_arch})

# *FIX: This has no effect.  cmake is using /bin/gmake
#set (CMAKE_MAKE_PROGRAM ${ANDROID_NDK}/prebuilt/linux-x86_64/bin CACHE FILEPATH FORCE)



include ($ENV{gem_fullpath_gem}/local/src/cmake/config_common.cmake)
