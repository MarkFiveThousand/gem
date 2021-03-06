cmake_policy( SET CMP0054 NEW )	# to "only interpret if() arguments	as variables
# or keywords when unquoted."
# Source: https://stackoverflow.com/questions/31037882/whats-the-cmake-syntax-to-set-and-use-variables/31044116#31044116

macro(gem_Msg str)

	message("${str}")

endmacro()

macro(gem_ExitMsg str)

	message(FATAL_ERROR "${str}")

endmacro()

# Problem: CMake runs toolchain	files multiple times, but can't	read cache
# variables	on some	runs.  Workaround: On first	run	(in	which cache	variables
# are always accessable), set an intermediary environment variable.
# Source: https://stackoverflow.com/questions/28613394/check-cmake-cache-variable-in-toolchain-file

macro(gem_Persist var)
	set( method 1 )	# The others don't	work when set in CMakeLists.txt, but read
					# from	toolchain.cmake.
	if	(${var})
		if( ${method} EQUAL 1 )
			# Store in environment variable.  Works!
			set(ENV{gem_Persist_${var}} "${${var}}")
			
		elseif( ${method} EQUAL 2 )
			# Store in GLOBAL property.
			set_property(GLOBAL PROPERTY	${var} ${${var}})

		elseif( ${method} EQUAL 3 )
			# Store in cache.
			set(${var} ${${var}} CACHE INTERNAL "")
		
		else()
			# Store in cache property.
			set_property(CACHE PROPERTY STRINGS ${var} ${${var}})
		endif()
#		gem_Msg("\ngem_Persist saved ${var} = ${${var}}.\n")
	else ()
		if( ${method} EQUAL 1 )
			# Retrieve from environment variable.  Works!
			set(${var} "$ENV{gem_Persist_${var}}")
			
		elseif( ${method} EQUAL 2 )
			# Retrieve from GLOBAL property.	 Not working.
			get_property(${var} GLOBAL PROPERTY ${var})
			
		elseif( ${method} EQUAL 3 )
			# Retrieve from cache.
			gem_Msg("Retrieved from cache: ${var}=${${var}}")

		else()
			# Retrieve from cache property.
			get_property(${var} CACHE Mark PROPERTY STRINGS)
		endif()
		if (NOT ${var})
			gem_ExitMsg("\ngem_Persist failed to retrieve ${var}.\n")
#		else()
#			gem_Msg("\ngem_Persist retrieved ${var}	= ${${var}}.\n")
		endif()
	endif ()
endmacro()

macro( gem_DebugDumpVars )

	gem_Msg("-------------------------------------------------------------------------")
	gem_Msg("cmake called with:")
	gem_Msg("    CMAKE_TOOLCHAIN_FILE =         ${CMAKE_TOOLCHAIN_FILE}")
	gem_Msg("    CMAKE_BUILD_TYPE =             ${CMAKE_BUILD_TYPE}")
	gem_Msg("    CMAKE_INSTALL_PREFIX =         ${CMAKE_INSTALL_PREFIX}")
	gem_Msg("    CMAKE_ANDROID_STANDALONE_TOOLCHAIN =")
	gem_Msg("                                   ${CMAKE_ANDROID_STANDALONE_TOOLCHAIN}")
	gem_Msg("    CMAKE_SYSROOT =                ${CMAKE_SYSROOT}")
	gem_Msg("    gem_target =                   ${gem_target}")
	gem_Msg("    ANDROID_ABI =                  ${ANDROID_ABI}")
	gem_Msg("    ANDROID_NATIVE_API_LEVEL =     ${ANDROID_NATIVE_API_LEVEL}")
	gem_Msg("    ANDROID_NDK =                  ${ANDROID_NDK}")
	gem_Msg("gem_platform_host =           	    ${gem_platform_host}")
	gem_Msg("gem_platform_host_details_suffix = ${gem_platform_host_details_suffix}")
	gem_Msg("gem_path_suffix =                  ${gem_path_suffix}")
	gem_Msg("gem_fullpath_src =                 ${gem_fullpath_src}")
	gem_Msg("gem_fullpath_build =               ${gem_fullpath_build}")
	gem_Msg("")
	gem_Msg("CMAKE_CROSSCOMPILING =   ${CMAKE_CROSSCOMPILING}")
	gem_Msg("CMAKE_C_COMPILER =       ${CMAKE_C_COMPILER}")
	gem_Msg("CMAKE_CXX_COMPILER =     ${CMAKE_CXX_COMPILER}")
	gem_Msg("-------------------------------------------------------------------------")

endmacro()

