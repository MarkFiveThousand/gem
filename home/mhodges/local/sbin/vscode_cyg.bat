C:\cygwin64\
rem Add MinGW binaries to the path.
set gem_fullpath_cyg=C:\cygwin64

PATH=%gem_fullpath_cyg%\bin;%PATH%
PATH=%gem_fullpath_cyg%\sbin;%PATH%
PATH=%gem_fullpath_cyg%\usr\sbin;%PATH%
PATH=%gem_fullpath_cyg%\usr\local\bin;%PATH%
PATH=%gem_fullpath_cyg%\usr\local\sbin;%PATH%

rem Add our gem-built binaries to the path.
set gem_fullpath_gem=%gem_fullpath_cyg%\home\%USERNAME%\gem
PATH=%gem_fullpath_gem%\local_x86_64-cygwin\release\bin;%PATH%

start "" "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe"

