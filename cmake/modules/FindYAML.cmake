# YAML support for loading and saving of any kind of settings
FetchContent_Declare(
  yaml
  GIT_REPOSITORY https://github.com/jbeder/yaml-cpp.git
  GIT_TAG yaml-cpp-0.7.0
  GIT_PROGRESS true
)
FetchContent_GetProperties(yaml)
if (NOT yaml_POPULATED)
    FetchContent_Populate(yaml)
	set(YAML_CPP_BUILD_TOOLS OFF CACHE BOOL "Turn off YAML tools")
	add_subdirectory(${yaml_SOURCE_DIR} ${yaml_BINARY_DIR})
endif()

set(YAML_LIBRARIES yaml-cpp)
set(YAML_INCLUDE_DIR "${yaml_SOURCE_DIR}/include")
