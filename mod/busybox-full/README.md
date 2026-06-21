# BusyBox Build Toolkit

This toolkit provides scripts to build a full-featured BusyBox binary for the NATYWISH_LTF7267 / NTT.

## Prerequisites

```bash
sudo apt-get update -y
sudo apt-get install -y build-essential gawk bison flex texinfo help2man gperf \
  libncurses-dev python3-dev autoconf automake libtool libtool-bin wget curl \
  bzip2 xz-utils unzip patch rsync git file
```

## Quick Start

Extract the toolkit, build the toolchain, and compile the BusyBox binary:

```bash
# Extract
tar xf busybox-buildkit-src.tar.gz && cd busybox-buildkit-src

# Step 1: Build the cross-compilation toolchain
./build-toolchain.sh

# Step 2: Build BusyBox (The output binary will be located at busybox-src/busybox)
./build-busybox.sh

# Step 3: Clean up build directory (Optional)
cd .. && rm -rf busybox-buildkit-src
```