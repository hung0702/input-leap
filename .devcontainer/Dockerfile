# Start from the official, multi-platform dev container base image for Debian 12.
# This image is known to be compatible with the Codespaces environment.
FROM mcr.microsoft.com/devcontainers/base:bookworm

# Switch to the root user to perform installations.
USER root

# Update package lists and install all build dependencies in a single command.
# This is more efficient and creates a cleaner Docker image layer.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y install --no-install-recommends \
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
        libxtst-dev \
        qt6-base-dev \
        qt6-tools-dev-tools \
        qt6-l10n-tools \
        g++ \
        pkg-config \
    # Clean up apt cache to reduce image size.
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Switch back to the default, non-root 'vscode' user for security.
USER vscode
