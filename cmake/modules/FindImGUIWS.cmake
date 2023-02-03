# library for loading and saving of images to png format

FetchContent_Declare(
	imguiws
	GIT_REPOSITORY https://github.com/ggerganov/imgui-ws.git
	GIT_TAG eab5d6b169ed3e5f8d26c4a6cd9a3271dd6e2dda
)

# sets the module path to our project level
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/modules")

FetchContent_GetProperties(imguiws)
if (NOT imguiws_POPULATED)
	find_package(ZLIB REQUIRED)
	
	FetchContent_Populate(imguiws)
	message(STATUS "Source directory: ${imguiws_SOURCE_DIR}")
	message(STATUS "Binary directory: ${imguiws_BINARY_DIR}")
	
	add_subdirectory(${imguiws_SOURCE_DIR} ${imguiws_BINARY_DIR})
endif()

set(ImGUIWS_FOUND TRUE)
set(ImGUIWS_INCLUDE_DIR "${imguiws_SOURCE_DIR}/include/imgui-ws")
set(ImGUIWS_LIBRARIES imgui-ws)