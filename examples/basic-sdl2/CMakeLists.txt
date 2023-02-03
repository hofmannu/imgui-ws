add_executable(basic-sdl2 main.cpp)
target_include_directories(basic-sdl2 PRIVATE ..)
target_link_libraries(basic-sdl2 PRIVATE ${ImGUI_LIBRARIES} imgui-ws)
