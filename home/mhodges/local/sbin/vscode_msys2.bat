
rem Add MinGW binaries to the path.
set gem_fullpath_mingw=C:\msys64
PATH=%gem_fullpath_mingw%\mingw64\bin;%PATH%
PATH=%gem_fullpath_mingw%\usr\bin;%PATH%

rem Add our gem-built binaries to the path.
set gem_fullpath_gem=%gem_fullpath_mingw%\home\%USERNAME%\gem
PATH=%gem_fullpath_gem%\local_x86_64-w64-mingw32\release\bin;%PATH%

start "" "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe"

