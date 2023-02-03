# a simple script to automatically retrieve SDL

find_package(SDL2 QUIET)
if (SDL2_FOUND)
    message(STATUS "Found a local SDL2 installation (v. ${SDL2_VERSION})")
    SET(SDL_INCLUDE_DIR "${SDL2_INCLUDE_DIRS}")
    SET(SDL_LIBRARIES "SDL2")
    SET(SDL_FOUND TRUE)
else()
    include(FetchContent)
    FetchContent_Declare(
        sdl
        GIT_REPOSITORY https://github.com/libsdl-org/SDL.git
        GIT_TAG release-2.26.2 # already SDL3 btw
        GIT_PROGRESS true
    )

	FetchContent_GetProperties(sdl)
	if(NOT sdl_POPULATED)
	    FetchContent_Populate(sdl)
	    option(SLD_STATIC "Build SDL2 as a static library" ON)
        option(SDL_SHARED "Build SDL2 as a shared library" OFF)
        option(SDL_TESTS "Build SDL2 tests" OFF)
        option(SDL_VIRTUAL_JOYSTICK "SDL virtual joystick support" OFF)
		option(SDL_METAL "SDL Metal support" OFF)

		message(STATUS "SDL source dir: ${sdl_SOURCE_DIR}")
		message(STATUS "SDL binary dir: ${sdl_BINARY_DIR}")

        add_subdirectory(${sdl_SOURCE_DIR} ${sdl_BINARY_DIR})
		
	endif()
	
    set(SDL_FOUND TRUE)
    set(SDL_VERSION 2.26.2)
    SET(SDL_INCLUDE_DIR "${sdl_SOURCE_DIR}/include")
    SET(SDL_LIBRARIES "SDL2::SDL2-static")
endif()