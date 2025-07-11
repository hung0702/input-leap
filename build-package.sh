#!/bin/bash
# This script builds the Input Leap project and packages it into a .deb file.
# It is designed to be run from within a properly configured GitHub Codespace.

# Exit immediately if a command exits with a non-zero status.
set -e

# ---
# 1. Configuration and Environment Setup
# ---
BUILD_DIR="input-leap-build"
# The source code is mounted by Codespaces at this location.
# This corresponds to the root of your repository.
SOURCE_DIR="/workspaces/input-leap"

echo "--- Creating clean build directory in home folder..."
rm -rf ~/$BUILD_DIR
mkdir -p ~/$BUILD_DIR
cd ~/$BUILD_DIR

# ---
# 2. Copy Source Code
# ---
echo "--- Copying source code from ${SOURCE_DIR} to build directory..."
# Copy the entire repository content into the current directory.
# This creates a clean copy for the build, separate from the original.
cp -a ${SOURCE_DIR} .

# The above command creates a directory named 'input-leap' inside our build directory.
# We now move into it to perform the build.
cd input-leap

# ---
# 3. Configure and Compile
# ---
echo "--- Configuring the build with CMake..."
cmake -S . -B build -D CMAKE_BUILD_TYPE=Release -D INPUTLEAP_BUILD_TYPE=Release

echo "--- Compiling Input Leap... This may take several minutes."
cmake --build build -j$(nproc)

# ---
# 4. Create Debian Package
# ---
echo "--- Packaging the application into a .deb file..."
cd build
cpack -G DEB

# ---
# 5. Final Output
# ---
echo ""
echo "=============================================================================="
echo " BUILD SUCCESSFUL"
echo "=============================================================================="
echo ""
echo "Your .deb package is located in the build directory:"
ls -l *.deb

