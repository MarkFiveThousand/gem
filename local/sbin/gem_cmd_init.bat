echo off

rem  ___________                           __________
rem /\   _______\                         /\   ______\
rem \ \  \______/_     ___   ____ ____ ___\ \  \_____/_     ___   ___ ___  ______    ___    ___
rem  \ \  \ /\__  \  /'___`\/\   V    V   \\ \_______  \  /'   `\/\  \\  \/\   __\/' ._`\ /'___`\
rem   \ \  \\/__\  \/\  ___/\ \  \/\  \/\  \\/_______\  \/\  \\  \ \  \\  \ \  \ /\  \__//\  ___/
rem    \ \__________\ \____\ \ \__\ \__\ \__\ /\_________\ \_____/\ \______\ \__\\ \____/\ \____\
rem     \/__________/\/____/  \/__/\/__/\/__/ \/_________/\/____/  \/______/\/__/ \/___/  \/____/
rem
rem
rem File: gem_cmd_init
rem
rem Configure Gem environment for Windows cmd terminal.
rem 

rem ===========================================================================
rem Query System Info
rem ===========================================================================
rem
rem *TODO: We need to obtain these from python.
set gem_os=windows
set gem_uname_machine=x86_64


rem ===========================================================================
rem Determine Gem Directory
rem ===========================================================================
set gem_fullpath_gem=%~dp0..\..


rem ===========================================================================
rem Path & Environment Variables
rem ===========================================================================

rem .pylintrc is generated using:
rem pylint --generate-rcfile > ${gem_fullpath_gem}/local/config/.pylintrc
rem Source: https://pylint.pycqa.org/en/latest/user_guide/run.html

set PYLINTRC=%gem_fullpath_gem%\local\config\.pylint.rc


rem ===========================================================================
rem Gem
rem ===========================================================================

rem Add Gem's executable scripts to PATH.
PATH=%gem_fullpath_gem%\local_x86_64-windows\release\bin;%PATH%


