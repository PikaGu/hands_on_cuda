#!/bin/bash

# 设置构建目录
BUILD_DIR="build"

# 如果构建目录不存在，则创建
if [ ! -d "$BUILD_DIR" ]; then
    mkdir "$BUILD_DIR"
fi

# 进入构建目录
cd "$BUILD_DIR"

# 运行 CMake 配置，如果已经配置过，则只会检测增量更改
cmake ..

# 编译项目
cmake --build . -- -j$(nproc)

mv ./cuda_demo.so ..
# 返回上级目录
cd ..

# 提示用户完成
echo "Build complete. Output located in: $BUILD_DIR"
