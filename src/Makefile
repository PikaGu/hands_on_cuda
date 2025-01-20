# 变量定义
CUDA_PATH := /usr/local/cuda
CXX := g++
NVCC := nvcc
TARGET := main
CUDA_SRC := $(wildcard kernel/*.cu)
CPP_SRC := main.cpp
OBJ := $(CUDA_SRC:.cu=.o) main.o
EXEC := $(TARGET)

# 编译选项
CXXFLAGS := -std=c++11
CUDA_FLAGS := -L$(CUDA_PATH)/lib64 -lcudart
INCLUDE_FLAGS := -I$(CUDA_PATH)/include

# 默认目标
all: $(EXEC)

# 编译 CUDA 文件
%.o: %.cu
	$(NVCC) -o $@ -c $< $(INCLUDE_FLAGS)

# 编译 C++ 文件
main.o: $(CPP_SRC)
	$(CXX) -o $@ -c $< $(CXXFLAGS) $(INCLUDE_FLAGS)

# 链接目标文件
$(EXEC): $(OBJ)
	$(CXX) -o $(EXEC) $(OBJ) $(CUDA_FLAGS)

# 生成 nsys profile report
prof: $(EXEC)
	@echo "Running with nsys for profiling..."
	nsys profile --stats=true --output=nsys_report ./$(EXEC)

# 清理生成的文件
clean:
	rm -f $(OBJ) $(EXEC) nsys_report.*

# 执行程序
run: $(EXEC)
	./$(EXEC)

# 伪目标
.PHONY: all clean prof run
