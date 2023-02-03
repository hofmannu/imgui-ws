# a helper script to easily get imgui and make it available for the current
# project

# imgui does not have a CMakeLists.txt file

include(FetchContent)

FetchContent_Declare(
	imgui
	GIT_REPOSITORY https://github.com/ocornut/imgui.git
	GIT_TAG 3ea0fad204e994d669f79ed29dcaf61cd5cb571d
	GIT_PROGRESS true
	# note: this git tag is pointing to the docking branch
)

FetchContent_GetProperties(imgui)
if (NOT imgui_POPULATED)
	# we use the imgui implementation here depends on SDL and GLFW
	find_package(SDL)
	find_package(GLFW)
	
	FetchContent_Populate(imgui)
	# message(STATUS "Imgui source dir: ${imgui_SOURCE_DIR}") <- works
	
	add_library(ImGUI_target
		${imgui_SOURCE_DIR}/imgui.cpp
		${imgui_SOURCE_DIR}/imgui_draw.cpp
		${imgui_SOURCE_DIR}/imgui_tables.cpp
		${imgui_SOURCE_DIR}/imgui_widgets.cpp
		${imgui_SOURCE_DIR}/backends/imgui_impl_sdl.cpp
		${imgui_SOURCE_DIR}/backends/imgui_impl_opengl3.cpp
		${imgui_SOURCE_DIR}/misc/cpp/imgui_stdlib.cpp
	)
	
	target_include_directories(ImGUI_target
	PUBLIC
		
	PRIVATE
		${imgui_SOURCE_DIR}
		${imgui_SOURCE_DIR}/backends
		${SDL_INCLUDE_DIR}
		${glfw_SOURCE_DIR}/include
	)

	# glfw3_LIBRARIES is empty
	target_link_libraries(ImGUI_target 
	PRIVATE
		${glfw3_LIBRARIES}
		${OPENGL_LIBRARIES}
	)

	set(ImGUI_INCLUDE_DIR
		${imgui_SOURCE_DIR}
		${imgui_SOURCE_DIR}/backends
		${imgui_SOURCE_DIR}/misc/cpp
	)
	set(ImGUI_FOUND TRUE)
	set(ImGUI_LIBRARIES "ImGUI_target")

endif()