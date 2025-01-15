import unittest
import numpy as np
import cuda_demo

class TestCudaDemo(unittest.TestCase):

    def compare_results(self, result, expected, tolerance=1e-5):
        self.assertTrue(np.allclose(result, expected, atol=tolerance), 
                        f"Test Failed! Expected: {expected}, Got: {result}")

    def test_vector_add(self):
        a = np.random.rand(1000).astype(np.float32)
        b = np.random.rand(1000).astype(np.float32)
        result = cuda_demo.add(a, b)
        self.compare_results(result, a+b)

    # def test_reduce(self):
    #     a = np.random.rand(100).astype(np.float32)
    #     result = cuda_demo.reduce(a)
    #     self.compare_results(result, np.sum(a))

    # def test_matmul(self):
    #     A = np.random.rand(3, 3).astype(np.float32)
    #     B = np.random.rand(3, 3).astype(np.float32)
    #     result = cuda_demo.matmul(A, B)
    #     self.compare_results(result, np.matmul(A, B))

if __name__ == '__main__':
    unittest.main()
