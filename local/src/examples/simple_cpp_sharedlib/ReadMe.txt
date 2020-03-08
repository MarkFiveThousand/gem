OVERVIEW:
------------------------------------------
This is intended to be the most simple C++ project that builds and links a
shared library.


IMPORTANT BUILD NOTES:

IMPORTING & EXPORTING SYMBOLS
------------------------------------------
See sharedlib.h.  Macros to aid in importing and exporting symbols have been
defined there.  Imported & exported symbols *must* be labelled SO_PUBLIC.

Private symbols *do not* need to be labelled SO_PRIVATE.  This is the case for
different reasons on Windows and Linux.  On Windows all .dll symbols are
private/not exported/not visible by default. On Linux, while all symbols are
public/exported/visible by default, we ought to be compiling with the 
"-fvisibility=hidden -fvisibility-inlines-hidden" options to hide all symbols,
except for the ones overridden with SO_PUBLIC.

Symbol visibility must be determined at compile time for the shared object
source files into the .o files that will later become the .so file.  Defining
this while building the .so from the .o has no effect.

Define SO_BUILDING by specifying -DSO_BUILDING on the gcc/g++ command line only
while compiling your .so. This will cause your SO_PUBLIC symbols to be exported/
visible.  Leave SO_BUILDING undefined while compiling any client of the .so.
This will allow your SO_PUBLIC symbols to be imported and available to the
client.

On windows SO_PUBLIC is only required in the .h file.  On Linux SO_PUBLIC is
only required in the .cpp files.  You definitely want to use it in both places
for it to work on both platforms.


EXECUTABLES FINDING THEIR SO'S
------------------------------
We want the executable to find the .sos in the same directory as the executable.
To do this, we need to embed the .so location in the executable.  Pass the
-Wl,-rpath=./ option to embed the .so location during linking, not compiling.
-W1 passes the option following the comma to the linker.  -rpath=./, tells the
executable where to look for the .so.

If your .so is named libshared.so, specify libshared.so while compiling the
executable.  Do include "lib" prefix. Do *not* use -l option because you are
using -rpath, so there is no need to search standard library directories, -l
indicates.



IMPORTANT EXCEPTION HANDLING ISSUES
-----------------------------------
See https://gcc.gnu.org/wiki/Visibility for important details regarding
visibility of thrown exceptions.



VALIDATING VISIBILITY RESULTS ON LINUX
--------------------------------------

SIDE NOTE: nm -C -D libshared.so should list all exported symbols in
libshared.so demangled form.  Unfortunately, this only works on Linux.

