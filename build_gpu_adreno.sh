#!/bin/bash
# GPU-Adreno-Build-Script (CLBlast/ocl-icd)

set -e

echo "Starting GPU-Accelerated llama-server build..."

# Ensure clean build directory
rm -rf build-gpu-adreno
mkdir build-gpu-adreno

# Configure build with CLBlast and ocl-icd
cmake -S llama.cpp -B build-gpu-adreno -DGGML_CLBLAST=ON -DCLBlast_DIR=/data/data/com.termux/files/usr/lib/cmake/CLBlast -DOpenCL_INCLUDE_DIR=/data/data/com.termux/files/usr/include -DOpenCL_LIBRARY=/data/data/com.termux/files/usr/lib/libOpenCL.so

# Build
cmake --build build-gpu-adreno --target llama-server --parallel 4

echo "Build complete."
