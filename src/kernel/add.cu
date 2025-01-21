#include <cuda_runtime.h>

#include "kernel.h"

__global__ void add(const float* a, const float* b, float* c, int n) {
  int idx = threadIdx.x + blockIdx.x * blockDim.x;
  if (idx < n) {
    c[idx] = a[idx] + b[idx];
  }
}

__global__ void add_float2(const float* a, const float* b, float* c, int n) {
  int idx = (threadIdx.x + blockIdx.x * blockDim.x) * 2;
  if (idx < n) {
    
  }
}

__global__ void add_float4(const float* a, const float* b, float* c, int n) {
  int idx = (threadIdx.x + blockIdx.x * blockDim.x) * 4;
  if (idx < n) {
    
  }
}

void launch_vector_add(const float* A, const float* B, float* C, int N, int version=0) {
  float *d_A, *d_B, *d_C;
  cudaMalloc((void**)&d_A, N * sizeof(float));
  cudaMalloc((void**)&d_B, N * sizeof(float));
  cudaMalloc((void**)&d_C, N * sizeof(float));

  cudaMemcpy(d_A, A, N * sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_B, B, N * sizeof(float), cudaMemcpyHostToDevice);

  int threads = 256;
  int blocks = (N + threads - 1) / threads;
  switch (version) {
  case 1:
    add_float2<<<blocks, threads>>>(d_A, d_B, d_C, N);
    break;
  case 2:
    add_float4<<<blocks, threads>>>(d_A, d_B, d_C, N);
    break;
  default:
    add<<<blocks, threads>>>(d_A, d_B, d_C, N);
    break;
  }

  cudaMemcpy(C, d_C, N * sizeof(float), cudaMemcpyDeviceToHost);

  cudaFree(d_A);
  cudaFree(d_B);
  cudaFree(d_C);
}
