cmake_minimum_required(VERSION 3.11)

gem_Msg("------------ ${CMAKE_CURRENT_LIST_FILE}")


set(PLATFORM_HOST x86_64-pc-linux-gnu)
set(PLATFORM_HOST_SUFFIX )

# *FIX: This has no effect.  cmake is using /bin/gmake
#set(CMAKE_MAKE_PROGRAM /bin/make)


# Include settings common to all platforms.
include($ENV{HOME}/local/src/cmake_utils/config_common.cmake)

