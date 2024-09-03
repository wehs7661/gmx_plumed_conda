#!/bin/bash

$PREFIX/bin/plumed-patch -p --runtime -e gromacs-$PKG_VERSION
mkdir build
cd build

cmake .. \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DGMX_SIMD=AVX2_256 \
    -DGMX_MPI=ON \
    -DGMX_BUILD_OWN_FFTW=ON

make -j "${nproc}"
make install
