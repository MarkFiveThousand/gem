#  ___________                           __________
# /\   _______\                         /\   ______\
# \ \  \______/_     ___   ____ ____ ___\ \  \_____/_     ___   ___ ___  ______   ____    ___
#  \ \  \ /\__  \  /'___`\/\   V    V   \\ \_______  \  /'   `\/\  \\  \/\   __\/' ._`\ /'___`\
#   \ \  \\/__\  \/\  ___/\ \  \/\  \/\  \\/_______\  \/\  \\  \ \  \\  \ \  \ /\  \__//\  ___/
#    \ \__________\ \____\ \ \__\ \__\ \__\ /\_________\ \_____/\ \______\ \__\\ \____/\ \____\
#     \/__________/\/____/  \/__/\/__/\/__/ \/_________/\/____/  \/______/\/__/ \/___/  \/____/


cmake_policy (SET CMP0054 NEW)	# to "only interpret if () arguments	as variables
# or keywords when unquoted."
# Source: https://stackoverflow.com/questions/31037882/whats-the-cmake-syntax-to-set-and-use-variables/31044116#31044116

function (gem_Msg str)
	message("${str}")

endfunction ()

function (gem_ExitMsg str)
	message (FATAL_ERROR "${str}")

endfunction ()

# Problem: CMake runs toolchain	files multiple times, but can't	read cache
# variables	on some	runs.  Workaround: On first	run	(in	which cache	variables
# are always accessible), set an intermediary environment variable.
# Source: https://stackoverflow.com/questions/28613394/check-cmake-cache-variable-in-toolchain-file

function (gem_Persist var)
	set (method 1)	# The others don't	work when set in CMakeLists.txt, but read
					# from	toolchain.cmake.
	if (${var})
		if (${method} EQUAL 1)
			# Store in environment variable.  Works!
			set (ENV{gem_Persist_${var}} "${${var}}")
			
		elseif (${method} EQUAL 2)
			# Store in GLOBAL property.
			set_property (GLOBAL PROPERTY	${var} ${${var}})

		elseif (${method} EQUAL 3)
			# Store in cache.
			set (${var} ${${var}} CACHE INTERNAL "")
		
		else()
			# Store in cache property.
			set_property (CACHE PROPERTY STRINGS ${var} ${${var}})
		endif ()
#		gem_Msg ("\ngem_Persist saved ${var} = ${${var}}.\n")

	else ()
		if (${method} EQUAL 1)
			# Retrieve from environment variable.  Works!
			set (${var} "$ENV{gem_Persist_${var}}")
			
		elseif (${method} EQUAL 2)
			# Retrieve from GLOBAL property.	 Not working.
			get_property (${var} GLOBAL PROPERTY ${var})
			
		elseif (${method} EQUAL 3)
			# Retrieve from cache.
			gem_Msg ("Retrieved from cache: ${var}=${${var}}")

		else()
			# Retrieve from cache property.
			get_property (${var} CACHE Mark PROPERTY STRINGS)
		endif ()
		if (NOT ${var})
			gem_ExitMsg ("\ngem_Persist failed to retrieve ${var}.\n")
#		else()
#			gem_Msg ("\ngem_Persist retrieved ${var}	= ${${var}}.\n")
		endif ()
	endif ()
endfunction ()

function (gem_DebugDumpVars)
	gem_Msg ("--------------------------- gem_DebugDumpVars ---------------------------")
	gem_Msg ("")
	gem_Msg ("CMake called with:")
	gem_Msg ("")
	gem_Msg ("    CMAKE_BUILD_TYPE =             ${CMAKE_BUILD_TYPE}")
	gem_Msg ("    CMAKE_INSTALL_PREFIX =         ${CMAKE_INSTALL_PREFIX}")
	gem_Msg ("    CMAKE_ANDROID_STANDALONE_TOOLCHAIN =")
	gem_Msg ("                                   ${CMAKE_ANDROID_STANDALONE_TOOLCHAIN}")
	gem_Msg ("        ANDROID_ABI =              ${ANDROID_ABI}")
	gem_Msg ("        ANDROID_NATIVE_API_LEVEL = ${ANDROID_NATIVE_API_LEVEL}")
	gem_Msg ("        ANDROID_NDK =              ${ANDROID_NDK}")
	gem_Msg ("")
	gem_Msg ("    CMAKE_SYSROOT =                ${CMAKE_SYSROOT}")
	gem_Msg ("    CMAKE_TOOLCHAIN_FILE =         ${CMAKE_TOOLCHAIN_FILE}")
	gem_Msg ("")
	gem_Msg ("Other Stuff of Interest:")
	gem_Msg ("")
	gem_Msg ("CMAKE_HOST_SYSTEM_NAME =       ${CMAKE_HOST_SYSTEM_NAME}")
	gem_Msg ("CMAKE_HOST_SYSTEM_PROCESSOR =  ${CMAKE_HOST_SYSTEM_PROCESSOR}")
	gem_Msg ("CMAKE_SYSTEM_NAME =            ${CMAKE_SYSTEM_NAME}")
	gem_Msg ("CMAKE_SYSTEM_VERSION =      ${CMAKE_SYSTEM_VERSION}")
	gem_Msg ("CMAKE_SYSTEM_PROCESSOR =    ${CMAKE_SYSTEM_PROCESSOR}")
	gem_Msg ("CMAKE_FIND_ROOT_PATH =      ${CMAKE_FIND_ROOT_PATH}")
	gem_Msg ("CMAKE_CROSSCOMPILING =      ${CMAKE_CROSSCOMPILING}")
	gem_Msg ("CMAKE_C_COMPILER =          ${CMAKE_C_COMPILER}")
	gem_Msg ("CMAKE_C_COMPILER_TARGET =   ${gem_triple}")
	gem_Msg ("CMAKE_CXX_COMPILER =        ${CMAKE_CXX_COMPILER}")
	gem_Msg ("CMAKE_CXX_COMPILER_TARGET = ${gem_triple}")
	gem_Msg ("-------------------------------------------------------------------------")

endfunction ()

