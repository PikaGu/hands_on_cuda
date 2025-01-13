import numpy as np

import sys
sys.path.append('./build')
import cuda_demo

# Generate random data
a = np.random.rand(1000).astype(np.float32)
b = np.random.rand(1000).astype(np.float32)

# Call CUDA Kernel
result = cuda_demo.vector_add(a, b)

# Verify result
print("Result:", result)
print("Expected:", a + b)
