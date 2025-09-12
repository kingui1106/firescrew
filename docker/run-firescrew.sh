#!/bin/sh
# 显示当前架构信息
echo "Container architecture: $(uname -m)"

fail() {
  echo "ERROR: $1"
  exit 1
}

# Determine the architecture
ARCH=$(uname -m)

# Map the architecture to the binary name
case $ARCH in
  x86_64) BINARY_ARCH=amd64 ;;
  aarch64) BINARY_ARCH=arm64 ;;
  # Add other architectures if needed
  *) echo "Unsupported architecture: $ARCH" && exit 1 ;;
esac

BINARY_PATH="/bins/firescrew.linux.${BINARY_ARCH}"
RTSP_SERVER_BINARY_PATH="/bins/rtspServer.linux.${BINARY_ARCH}"

if [ ! -f "$BINARY_PATH" ]; then
  echo "Binary not found for Architecture: $ARCH"
  exit 1
fi
echo "[+] Checking for updates self..."
${BINARY_PATH} update

$BINARY_PATH "$@"

