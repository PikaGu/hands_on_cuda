#include "kernel/kernel.h"

#include <pybind11/pybind11.h>
#include <pybind11/numpy.h>

namespace py = pybind11;

py::array_t<float> add(py::array_t<float> A, py::array_t<float> B) {
    auto bufA = A.request(), bufB = B.request();
    float* ptrA = static_cast<float *>(bufA.ptr);
    float* ptrB = static_cast<float *>(bufB.ptr);
    int N = bufA.size;

    py::array_t<float> result(N);
    auto bufC = result.request(true);
    float* ptrC = static_cast<float *>(bufC.ptr);
    launch_vector_add(ptrA, ptrB, ptrC, N);
    return result;
}

PYBIND11_MODULE(cuda_demo, m) {
    m.def("add", &add, "cuda kernel vector add");
}
