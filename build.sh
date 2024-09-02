#!/bin/bash

# Install GROMACS 2023.5 (automatically downloaded as instructed by meta.yaml)
plumed patch -p -e gromacs-2023.5
mkdir build && cd build
cmake .. \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DGMX_SIMD=AVX2_256 \
    -DGMX_MPI=ON \
    -DGMX_BUILD_OWN_FFTW=ON
make -j$(nproc)
make install
cd ../
rm -rf gromacs-2023.5
