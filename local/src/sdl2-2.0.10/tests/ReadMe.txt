EXCELLECT RESOURCE: HOW TO BUILD SDL2 AND YOUR APP FOR ANDROID:
https://wiki.libsdl.org/Android
and
https://hg.libsdl.org/SDL/file/default/docs/README-android.md


FileTest_00
-----------
This is my first android app.  It is a sandbox for figuring out basic file i/o
on android.  It stores a .wav file in an assets/ directory and streams it.


LinkTest
--------
Testing building a simple sdl app and linking with sdl built as a separate
shared library project.


hello_sdl
---------
This builds under Android, Windows and Linux.  It renders the testgl.c and
testgles2.c.  You will need to change the .x extension to .c to switch to and
from Android.

ISSUES:
1st.) The sdl buildtool needs to be updated.  The Android version of hello_sdl
is building the sdl.so everytime. This needs to be built separate from the
hello_sdl source executable.

2nd.) All the path variables are not used under Windows and Linux.
Move them into CMakeLists.txt for Android, to clean up the buildtool script.
Buildtool accepts the build types Debug, Release, RelWithDebInfo, MinSizeRel
and is passing them on to cmake.  CMakeLists.txt is doing the following:

SET(CMAKE_CONFIGURATION_TYPES ${CMAKE_BUILD_TYPE})

... but we apparently need to do more than that to get build type working.

