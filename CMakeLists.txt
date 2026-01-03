cmake_minimum_required(VERSION 4.2.0)

project(cpp_template LANGUAGES CXX CUDA)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

set(CMAKE_CUDA_ARCHITECTURES "native")

set(CMAKE_CXX_USE_RESPONSE_FILE_FOR_INCLUDES 0)
set(CMAKE_CUDA_USE_RESPONSE_FILE_FOR_INCLUDES 0)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

if(MSVC)
else()
    add_compile_options(-Wall -Wextra -Wpedantic)
    
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        add_compile_options(-g -O0)
        message(STATUS "Build type: DEBUG")
    else()
        add_compile_options(-O3)
        message(STATUS "Build type: RELEASE")
    endif()
endif()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(FMT_INSTALL OFF CACHE INTERNAL "")
set(FMT_TEST OFF CACHE INTERNAL "")

add_subdirectory(external/fmt)
add_subdirectory(src)

add_custom_target(run
    COMMAND ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cpp_template
    DEPENDS cpp_template 
    WORKING_DIRECTORY ${CMAKE_PROJECT_DIR} 
    COMMENT "Running the application..."
)
