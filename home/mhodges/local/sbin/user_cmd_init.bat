rem
rem  ___________                           __________
rem /\   _______\                         /\   ______\
rem \ \  \______/_     ___   ____ ____ ___\ \  \_____/_     ___   ___ ___  ______   ____    ___
rem  \ \  \ /\__  \  /'___`\/\   V    V   \\ \_______  \  /'   `\/\  \\  \/\   __\/' ._`\ /'___`\
rem   \ \  \\/__\  \/\  ___/\ \  \/\  \/\  \\/_______\  \/\  \\  \ \  \\  \ \  \ /\  \__//\  ___/
rem    \ \__________\ \____\ \ \__\ \__\ \__\ /\_________\ \_____/\ \______\ \__\\ \____/\ \____\
rem     \/__________/\/____/  \/__/\/__/\/__/ \/_________/\/____/  \/______/\/__/ \/___/  \/____/
rem
rem
rem File: user_cmd_init.bat
rem
rem Purpose: Running this Windows batch file grooms the cmd.com shell for
rem building projects using the gem build scripts.  gem_build, is located at
rem %gem_fullpath_gem%\local\sbin.  It sets %gem_fullpath_gem%.
rem
rem ===========================================================================
rem Sources
rem ===========================================================================
rem https://www.dostips.com/
rem https://ss64.com/nt/syntax.html
rem http://davesamuels.com/utils/BatchFileTricks.txt


call :PathAppend "C:\Program Files\KDiff3\KDiff3.exe"
rem call :PathAppend "C:\Program Files\KDiff3\"
goto :End

rem ===========================================================================
rem Configure user-specific environment and startup programs.
rem ===========================================================================
set gem_path_additions=

rem Git command line needs to know which editor you use:
set "EDITOR=code"


rem ===========================================================================
rem Android SDK
rem ===========================================================================
@echo off & setlocal enableExtensions enabledelayedexpansion
set gem_fullpath_android=C:\Android
set gem_fullpath_android_sdk=!gem_fullpath_android!\sdk-tools-windows-4333796
set ANDROID_SDK=!gem_fullpath_android_sdk!
endlocal

rem ===========================================================================
rem VS Code
rem ===========================================================================
:VerifyCode
	@echo off & setlocal enableExtensions enabledelayedexpansion
	echo.
	rem Validate VS Code is installed.
	rem
	rem Iterate over the results of 'where code'.  Note, where does not find
	rem system utilities like cd.  It also is not finding Code.exe, perhaps
	rem Microsoft has deemed it to be a system tool, or some similar reason.
	rem This should produce 2 results in the bin folder, each one level below
	rem the location of Code.exe.  We will assemble the path to Code.exe then
	rem validate our result.

	rem Store result of 'where code' in array_where[] with the array size stored in
	rem array_where_length.
	set /a "array_where_length=0"
	for /f "delims=" %%x in ('"where code 2> nul"') do (
		set "array_where[!array_where_length!]=%%x"
		set /a "array_where_length+=1"
	)

	rem Iterate over found paths.
	set /a "array_where_length-=1"
	for /L %%i in (0, 1, !array_where_length!) do (
		rem Test if fullpath contains "Microsoft VS Code".
		set fullpath=!array_where[%%i]!
		if not "!fullpath:Microsoft VS Code=!" == "!fullpath!" (
			call :GetParentDir "!fullpath!"
			call :GetParentDir "!gem_result_GetParentDir!"
			set path_code=!gem_result_GetParentDir!\Code.exe
			if exist !path_code! goto :VerifyCodeSucceed
		)
	)
	:VerifyCodeFail
		echo Microsoft VS Code installation not found.  Consider downloading it from https://code.visualstudio.com/download.
		goto :VerifyCodeEnd
	:VerifyCodeSucceed
		echo Found VS Code installation:
		echo     !path_code!
		goto :VerifyCodeEnd
	:VerifyCodeEnd
		set noop=0
	endlocal


rem ===========================================================================
rem KDiff3
rem ===========================================================================
:VerifyKDiff3
	@echo off & setlocal enableExtensions enabledelayedexpansion
	echo.
	call :FindExe kdiff3 "C:\Program Files\KDiff3\KDiff3.exe" "mhodges" "http://kdiff3.sourceforge.net"
	set gem_fullpath_kdiff3=!gem_result_FindExe!
	endlocal


rem ===========================================================================
rem CMake
rem ===========================================================================
:VerifyCMake
	@echo off & setlocal enableExtensions enabledelayedexpansion
	echo.
	call :FindExe cmake "C:\Program Files\CMake\bin\cmake.exe" "\Program Files\CMake\bin" "https://cmake.org/download"
	set gem_fullpath_cmake=!gem_result_FindExe!
	endlocal


rem ===========================================================================
rem Python
rem ===========================================================================
:VerifyPython
	@echo off & setlocal enableExtensions enabledelayedexpansion
	echo.
	call :FindExe python "" "\Programs\Python\" "https://www.python.org/downloads"
	set gem_fullpath_python=!gem_result_FindExe!
	endlocal


rem ===========================================================================
rem Pylint
rem ===========================================================================
:VerifyPylint
	@echo off & setlocal enableExtensions enabledelayedexpansion
	echo.
	if exist gem_fullpath_python\Scripts\pylint.exe goto :VerifyPylintEnd (
		set "gem_fullpath_pylint=!gem_fullpath_python!\Scripts"
	) else (
		echo Pylint appears to not be installed.  Consider installing it by entering the following command:
		echo.
		echo     pip3 install pylint.
	)
:VerifyPylintEnd
	endlocal

rem ===========================================================================
rem Suggest Path Modifications
rem ===========================================================================

echo --------------------------------------------------------------------------
if not "!gem_path_additions!"=="" (
	echo It is recommended that you add the following to your Windows path:
	echo.
	echo !gem_path_additions!
	echo.
	echo See https://www.google.com/search?q=add+variable+to+windows+path.
) else (
	echo "No recommendations."
)



rem ===========================================================================
rem Finally, where would you like to go today?
rem ===========================================================================
if exist !gem_fullpath_gem!\local\src (
	cd !gem_fullpath_gem!\local\src)


rem ===========================================================================
rem Subroutines
rem ===========================================================================
goto :End
rem ---------------------------------------------------------------------------
rem GetParentDir()- Given a fully qualified path terminating in either a file
rem name or directory name, will return in gem_result_GetParentDir the portion
rem of the path preceeding the last backslash.  If the given path contains a
rem trailing backslash it will be ignored and the directory above the last will
rem be returned in gem_result_GetParentDir.
rem ---------------------------------------------------------------------------
:GetParentDir
	@echo off & setlocal enableExtensions enabledelayedexpansion
	set gem_result_GetParentDir=
	set param=%~1
	set /a "j=0"
	set /a "index_slash=-1"
	set ch_curr=%param:~0,1%
	set ch_next=%param:~1,1%
rem		echo BEFORE  j=!j!  !ch_curr!  !ch_next!
:Char_Next
		if "!ch_curr!" equ "\" (
rem			echo Slash at !j!
			if "!ch_next!" neq "" (
rem				echo Not end of string.
				set /a "index_slash=!j!"
			) else (
rem				echo Slash at end of String
				rem End of string.
				goto :GetParentDir_End )
		)
		set ch_curr=!ch_next!
		set /a "j+=1"
		set /a "k=!j!+1"
		call set "ch_next=%%%param:~!k!,1%%%"
rem		echo AFTER   j=!j!  !ch_curr!  !ch_next!
		if "!ch_curr!" neq "" goto :Char_Next
rem		echo End of string.
	:GetParentDir_End
	call set "_gem_result_GetParentDir=%%param:~0,!index_slash!%%"

	endlocal & set "gem_result_GetParentDir=%_gem_result_GetParentDir%"

	exit /b


rem ---------------------------------------------------------------------------
rem FindExe()- Uses the where command to locate a given executable.  Where only
rem searches for executables in folders listed in the path.  If the excutable is
rem not found, then it will look in the extected default installation location
rem in case it is present, but it's location not included in the path.  If more
rem than one executable is found, then it will choose the first one that matches
rem the given substring.  If the executable is found it will be returned in
rem gem_result_FindExe, otherwise gem_result_FindExe will be unset.
rem ---------------------------------------------------------------------------
:FindExe
	@echo off & setlocal enableExtensions enabledelayedexpansion
	set "where_exe=%~1"
	set "fullpath_install_exe_default=%~2"
	set "preferred_substr_path=%~3"
	set "url_download=%~4"

	rem Store result of the where command in array_where[] with the array size stored
	rem in array_where_length.
	set /a "array_where_length=0"
	for /f "delims=" %%x in ('"where !where_exe! 2> nul"') do (
		set array_where[!array_where_length!]=%%x
		set /a "array_where_length+=1"
	)

	rem Alert the user if the where command didn't find where_exe, yet it is found
	rem in the default installation location.  The user should add it to their path.
	set gem_result_FindExe=
	rem If it's not in the path ...
	if !array_where_length! equ 0 (
		rem ... but it exists in the default installation location, ...
		if exist "!fullpath_install_exe_default!" (
			rem ... they need to add it to their path.
			echo Found '!where_exe!' in the default installation location !fullpath_install_exe_default!, but it's not in your path.  Consider adding it for easier command line usage.  See https://www.google.com/search?q=add+variable+to+windows+path.
			set "gem_result_FindExe=!fullpath_install_exe_default!"


			rem WAIT A MINUTE!!!!  Just call :PathAppend, as below.
			rem If gem_path_additions already has a path, then we need to add a
			rem `;'  prior to adding the new path.
			if not "!gem_path_additions!"=="" (set "gem_path_additions=!gem_path_additions!;")
			rem Append app's default install directory.
			set "gem_path_additions=!gem_path_additions!!fullpath_install_exe_default!"
			rem
			call :PathAppend "!fullpath_install_exe_default!"

		) else (
			echo Failed to find a '!where_exe!' installation.  Consider downloading it from !url_download!.
		)
	) else (
		echo Found !array_where_length! '!where_exe!' installation(s^):

		set /a "index_preferred=0"
		set /a "index_last=!array_where_length!-1"
		for /L %%i in (0, 1, !index_last!) do (

			rem Does this path match our preference substring?  That's
			rem choice=space in the line directly below.  Don't delete the ' '!
			set choice= 
			rem        ^- Space should be right there.
			set fullpath=!array_where[%%i]!
			set a=!fullpath:%preferred_substr_path%=!
			set b=!array_where[%%i]!
			if not "!a!" == "!b!" (
				rem This path matches our preference substring.
				if !index_preferred!==0 (
					set /a "index_preferred=%%i"
					set choice=*
				)
			)
			set /a "number=%%i+1"
			echo   !choice! !number!.^) !array_where[%%i]!
		)
		call set "gem_result_FindExe=%%array_where[!index_preferred!]%%"
	)
	endlocal
	exit /b


rem ---------------------------------------------------------------------------
rem PathAppend()- Appends the given directory to the user's path.  If %1 is a
rem file rather than a directory, then the directory containing the file will be
rem added to the path.
rem
rem Source: https://stackoverflow.com/questions/43934167/how-to-get-only-the-user-path-variable
rem ---------------------------------------------------------------------------
:PathAppend
	set MARK=%MARK%_HODGES
	echo %MARK%

	set fullpath=%~1

	rem If we were given a file, keep only the parent folder in fullpath.
	set attr=%~a1
	set dirAttr=%attr:~0,1%
	if /I not "%dirAttr%"=="d" (
		call :GetParentDir "!fullpath!"
		call set "fullpath=!gem_result_GetParentDir!"
	)


	@echo off disableDelayedExpansion

	rem Get directly from Windows registry the system PATH variable value.
	set "path_expand="
	set "path_system="
	for /F "skip=2 tokens=1,2*" %%G in ('%SystemRoot%\System32\reg.exe query "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /v "Path" 2^>nul') do if /I "%%G" == "Path" (
		if /I "%%H" == "REG_EXPAND_SZ" (set "path_expand=1" & set "path_system=%%I") else if /I "%%H" == "REG_SZ" set "path_system=%%I"
		if defined path_system goto GetUserPath
	)

	rem Get directly from Windows registry the user PATH variable value.
	:GetUserPath
	set "path_user="
	for /F "skip=2 tokens=1,2*" %%G in ('%SystemRoot%\System32\reg.exe query "HKCU\Environment" /v "Path" 2^>nul') do if /I "%%G" == "Path" (
		if /I "%%H" == "REG_EXPAND_SZ" (set "path_expand=1" & set "path_user=%%I") else if /I "%%H" == "REG_SZ" set "path_user=%%I"
		if defined path_user goto SetPath
	)

	rem Concatenate the two PATH values to a single value.
	rem Expand the environment variable references if that is necessary at all.
	rem Next replace all two consecutive semicolons by a single semicolon.
	rem Last remove semicolon from end of the directories list if there is one.

	:SetPath
	endlocal
	endlocal
	set "path=%path_system%;%path_user%;%fullpath%"
	if defined path_expand call set "path=%path%"
	set "path=%path:;;=;%"
	if "%path:~-1%" == ";" set "path=%path:~0,-1%"
	echo !path!
	echo -----
	echo %path%
	endlocal
	endlocal
	echo !path!
	echo -----
	echo %path%


	exit /b


:End