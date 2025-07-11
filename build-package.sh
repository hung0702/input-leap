#!/bin/bash
# This script builds the Input Leap project and packages it into a .deb file.
# It is designed to be self-contained and run from the root of the repository
# in a Debian-based Codespace.

# Exit immediately if a command exits with a non-zero status.
set -e

# ---
# 1. Install All Dependencies
# ---
# This section ensures all required build tools and libraries are present.
echo "--- Updating package lists and installing all dependencies..."
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    git \
    cmake \
    libavahi-compat-libdnssd-dev \
    libcurl4-openssl-dev \
    libgtest-dev \
    libssl-dev \
    libsystemd-dev \
    libx11-dev \
    libxext-dev \
    libxinerama-dev \
    libxkbcommon-dev \
    libxrandr-dev \
    libxtst-dev \
    libice-dev \
    libsm-dev \
    qt6-base-dev \
    qt6-tools-dev-tools \
    qt6-l10n-tools \
    g++ \
    pkg-config

echo "--- All dependencies installed successfully."

# ---
# 2. Configure and Compile
# ---
# The script is run from the root of the repository, so we build from here.
echo "--- Configuring the build with CMake..."
cmake -S . -B build -D CMAKE_BUILD_TYPE=Release -D INPUTLEAP_BUILD_TYPE=Release

echo "--- Compiling Input Leap... This may take several minutes."
cmake --build build -j$(nproc)

# ---
# 3. Create Debian Package
# ---
echo "--- Packaging the application into a .deb file..."
cd build
cpack -G DEB

# ---
# 4. Final Output
# ---
echo ""
echo "=============================================================================="
echo " BUILD SUCCESSFUL"
echo "=============================================================================="
echo ""
echo "Your .deb package is located in the build/ directory:"
ls -l *.deb
