import numpy as np
import cuda_demo

# Generate random data
a = np.random.rand(50).astype(np.float32)
b = np.random.rand(50).astype(np.float32)

# Call CUDA Kernel
result = cuda_demo.add(a, b)

# Verify result
print("Result:", result)
print("Expected:", a + b)
