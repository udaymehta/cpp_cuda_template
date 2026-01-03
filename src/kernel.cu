#include <stdio.h>

#include <kernel.cuh>

__global__ void hello_cuda() {
    printf("Hello from GPU thread %d!\n", threadIdx.x);
}

void launch_kernel() {
    hello_cuda<<<1, 5>>>();
    cudaDeviceSynchronize();
}
