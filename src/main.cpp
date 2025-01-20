#include "kernel/kernel.h"

#include <cstdio>
#include <cstdlib>
#include <ctime>

void random_fill(float *data, int size) {
    for (int i = 0; i < size; ++i) {
        data[i] = std::rand() % 10000 / 100.0;
    }
}


int main() {
    const int N = 10;
    float* A = new float[N];
    float* B = new float[N];
    float* C = new float[N];
    
    std::srand(std::time(nullptr));
    random_fill(A, N);
    random_fill(B, N);
    launch_vector_add(A, B, C, N);
    for (int i = 0; i < N; i++) {
        printf("%.2f + %.2f = %.2f\n", A[i], B[i], C[i]);
    }

    delete[] A;
    delete[] B;
    delete[] C;

    return 0;
}