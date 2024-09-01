#!/bin/bash

# Download and extract GROMACS
wget ftp://ftp.gromacs.org/pub/gromacs/gromacs-2023.5.tar.gz
tar -zxvf gromacs-2023.5.tar.gz
cd gromacs-2023.5

# Create build directory
mkdir build && cd build

# Configure the build
cmake .. \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DGMX_SIMD=AVX2_256 \
    -DGMX_MPI=ON \
    -DGMX_BUILD_OWN_FFTW=ON

# Patch with PLUMED
plumed patch -p -e gromacs-2023.5

# Compile and install
make -j$(nproc)
make install

# Clean up
cd ..
rm -rf gromacs-2023.5
