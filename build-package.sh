#!/bin/bash
set -e

BUILD_DIR="input-leap-build"
echo "--- Creating clean build directory..."
rm -rf ~/$BUILD_DIR
mkdir -p ~/$BUILD_DIR
cd ~/$BUILD_DIR

echo "--- Cloning a fresh copy of the source code..."
# The codespace workspace is mounted at /workspaces/your-repo-name
# We copy from there to ensure we build the exact version of the code
# from the branch the codespace was opened on.
cp -a /workspaces/$(basename $PWD) ./input-leap
cd input-leap

echo "--- Configuring the build with CMake..."
cmake -S . -B build -D CMAKE_BUILD_TYPE=Release -D INPUTLEAP_BUILD_TYPE=Release

echo "--- Compiling Input Leap..."
cmake --build build -j$(nproc)

echo "--- Packaging the application into a .deb file..."
cd build
cpack -G DEB

echo ""
echo "======================"
echo " BUILD SUCCESSFUL"
echo "======================"
echo "Your .deb package is in the build directory:"
ls -l *.deb