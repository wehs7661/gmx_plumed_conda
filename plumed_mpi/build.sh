#! /usr/bin/env bash

if [[ $(uname) == "Linux" ]]; then
  export STATIC_LIBS=-Wl,-rpath-link,$PREFIX/lib
  export LIBS="-lrt $LIBS"
fi

export CPPFLAGS="-D__PLUMED_DEFAULT_KERNEL=$PREFIX/lib/libplumedKernel$SHLIB_EXT $CPPFLAGS"
export CXXFLAGS="${CXXFLAGS//-O2/-O3}"

./configure --prefix=$PREFIX CXX=mpicxx CC=mpicc

make -j${nproc}
make install
