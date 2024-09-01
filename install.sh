# Install PLUMED 2.9.0
cd /jet/home/${USER}/src/PLUMED
git clone https://github.com/plumed/plumed2.git plumed_2.9
cd plumed_2.9  && mkdir plumed2_build
git checkout v2.9.0
module load openmpi/4.0.5-gcc10.2.0
./configure --prefix=/jet/home/${USER}/src/PLUMED/plumed_2.9/plumed2_build CXX="$MPICXX"
make -j $(nproc)
make install
source /jet/home/${USER}/src/PLUMED/plumed_2.9/sourceme.sh

# Install GROAMCS 2023.5_mpi and patch PLUMED 2.9 to it
cd /jet/home/${USER}/src/GROMACS
wget ftp://ftp.gromacs.org/pub/gromacs/gromacs-2023.5.tar.gz
tar -zxvf gromacs-2023.5.tar.gz
cd gromacs-2023.5
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/jet/home/${USER}/pkgs/gromacs/2023.5 -DGMX_SIMD=AVX2_256 -DGMX_MPI=on -DGMX_BUILD_OWN_FFTW=ON
cd ../
make -j $(nproc)
export PATH=$PATH:/usr/local/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
plumed patch -p -e gromacs-2023.5
make install
source /jet/home/${USER}/pkgs/gromacs/2023.5/bin/GMXRC

