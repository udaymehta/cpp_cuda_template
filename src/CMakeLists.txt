add_executable(${PROJECT_NAME}
    main.cpp
    kernel.cu
)

target_include_directories(${PROJECT_NAME} PUBLIC
    ${CMAKE_SOURCE_DIR}/include
)

target_link_libraries(${PROJECT_NAME} PRIVATE fmt::fmt)

set_target_properties(${PROJECT_NAME} PROPERTIES
    CUDA_SEPARABLE_COMPILATION ON
)
