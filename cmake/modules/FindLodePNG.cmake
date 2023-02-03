# library for loading and saving of images to png format
FetchContent_Declare(
	lodepng
	GIT_REPOSITORY https://github.com/lvandeve/lodepng.git
	GIT_TAG 997936fd2b45842031e4180d73d7880e381cf33f
)
FetchContent_MakeAvailable(lodepng)

add_library(lodepng_TARGET ${lodepng_SOURCE_DIR}/lodepng.cpp)

set(LodePNG_LIBRARIES "lodepng_TARGET" CACHE PATH "lodepng include directory" FORCE)
set(LodePNG_INCLUDE_DIR ${lodepng_SOURCE_DIR} CACHE PATH "lodepng include directory" FORCE)