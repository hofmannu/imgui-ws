# an extended cmake module finder for the HDF5 library. 
# https://cmake.org/cmake/help/latest/manual/cmake-developer.7.html

find_package(HDF5 QUIET COMPONENTS CXX)
if (HDF5_FOUND)
    message(STATUS "Detected HDF5 libraries: ${HDF5_LIBRARIES}")
    message(STATUS "Found a local HDF5 installation (v. ${HDF5_VERSION})")
    set(HDF_LIBRARIES "${HDF5_LIBRARIES}")
    message(STATUS "HDF5 exported targets: ${hdf5_EXPORTED_TARGETS}")
    set(HDF_INCLUDE_DIR "${HDF5_INCLUDE_DIRS}")
else()
    if(${CMAKE_VERSION} VERSION_GREATER_EQUAL "3.12.0")
        if (NOT HDF_FOUND)   
            # in CMakeLists.txt of HDF5 there are set_global_variable commands
            # those are the variables we will have available on this level here
            FetchContent_Declare(
                hdf
                GIT_REPOSITORY https://github.com/HDFGroup/hdf5.git
                GIT_TAG hdf5-1_12_2
			    GIT_PROGRESS true
            )
            FetchContent_GetProperties(hdf)
		
            if(NOT hdf_POPULATED)
                FetchContent_Populate(hdf)

                option(HDF5_BUILD_FORTRAN           "Build FORTRAN support"         OFF)
                option(HDF5_BUILD_CPP_LIB           "Build HDF5 C++ Library"        ON )
                option(HDF5_BUILD_HL_LIB            "Build HIGH Level HDF5 Library" OFF)
                option(BUILD_SHARED_LIBS            "Build Shared Libraries"        OFF)
                option(HDF5_BUILD_TOOLS             "Build HDF5 Tools"              OFF)
                option(HDF5_BUILD_UTILS             "Build HDF5 Utils"              OFF)
                option(HDF5_BUILD_EXAMPLES          "Build HDF5 Library Examples"   OFF)
                set(BUILD_TESTING OFF CACHE BOOL "Build HDF5 Unit Testing" FORCE)
                # note: option does not seem to work for the build testing flag
                option(HDF5_ENABLE_PARALLEL         "Enable parallel build"         OFF)
                option(HDF5_ENABLE_Z_LIB_SUPPORT    "Disable Zlib support"          OFF)
			
                add_subdirectory(${hdf_SOURCE_DIR} ${hdf_BINARY_DIR})
		    
		    else()
		        message(STATUS "HDF5 already downloaded")
		    endif()
        endif()
		set(HDF_INCLUDE_DIR
            ${hdf_SOURCE_DIR}/c++/src
            ${hdf_SOURCE_DIR}/src/H5FDsubfiling
            ${hdf_SOURCE_DIR}/src
            # ${hdf_SOURCE_DIR}/test
            ${hdf_BINARY_DIR}/src
        )
			
        message(STATUS "HDF5 lib target ${hdf_LIB_TARGET}")
		# hdf_LIB_TARGET: empty
		
        set(HDF_LIBRARIES 
            "hdf5_cpp-static"
        )
			
		message(STATUS "HDF exported targets: ${HDF_LIBRARIES}")
			
        set(HDF_FOUND TRUE)

    else()
        message(FATAL_ERROR "Environment (cmake < 3.12) unsuited for automatic HDF5 retrieval!")
    endif()
endif()
