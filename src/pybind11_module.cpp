#include "kernel/kernel.h"

#include <pybind11/pybind11.h>
#include <pybind11/numpy.h>

namespace py = pybind11;

void add(py::array_t<float> A, py::array_t<float> B, py::array_t<float> C) {
    auto bufA = A.request(), bufB = B.request(), bufC = C.request(true);
    float *ptrA = static_cast<float *>(bufA.ptr);
    float *ptrB = static_cast<float *>(bufB.ptr);
    float *ptrC = static_cast<float *>(bufC.ptr);
    int N = bufA.size;

    launch_vector_add(ptrA, ptrB, ptrC, N);
}

PYBIND11_MODULE(cuda_demo, m) {
    m.def("add", &add, "cuda kernel vector add");
}
