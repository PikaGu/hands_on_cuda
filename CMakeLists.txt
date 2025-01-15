cmake_minimum_required(VERSION 3.10)
project(CudaDemo LANGUAGES CXX CUDA)

add_subdirectory(external/pybind11)

set(PYBIND11_FINDPYTHON ON)
find_package(CUDAToolkit REQUIRED)

# CUDA configuration
# set(CMAKE_CUDA_STANDARD 14)
set(CMAKE_CUDA_ARCHITECTURES native)

set(KERNEL_SRC_DIR "${PROJECT_SOURCE_DIR}/src/kernel")
file(GLOB KERNEL_CU_FILES "${KERNEL_SRC_DIR}/*.cu")
set(SRC_FILES ${KERNEL_CU_FILES} ${PROJECT_SOURCE_DIR}/src/pybind11_module.cpp)

pybind11_add_module(cuda_demo ${SRC_FILES})
set_target_properties(cuda_demo PROPERTIES SUFFIX ".so")

# Include directories
target_include_directories(cuda_demo PRIVATE ${KERNEL_SRC_DIR})

# Link CUDA
target_link_libraries(cuda_demo PRIVATE CUDA::cudart)
