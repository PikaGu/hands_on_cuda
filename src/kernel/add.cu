#include <cuda_runtime.h>

#include "kernel.h"

__global__ void add(const float* a, const float* b, float* c, int n) {
  int idx = threadIdx.x + blockIdx.x * blockDim.x;
  if (idx < n) {
    c[idx] = a[idx] + b[idx];
  }
}

void launch_vector_add(const float* A, const float* B, float* C, int N) {
  float *d_A, *d_B, *d_C;
  cudaMalloc((void**)&d_A, N * sizeof(float));
  cudaMalloc((void**)&d_B, N * sizeof(float));
  cudaMalloc((void**)&d_C, N * sizeof(float));

  cudaMemcpy(d_A, A, N * sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_B, B, N * sizeof(float), cudaMemcpyHostToDevice);

  int threads = 256;
  int blocks = (N + threads - 1) / threads;
  add<<<blocks, threads>>>(d_A, d_B, d_C, N);

  cudaMemcpy(C, d_C, N * sizeof(float), cudaMemcpyDeviceToHost);

  cudaFree(d_A);
  cudaFree(d_B);
  cudaFree(d_C);
}
