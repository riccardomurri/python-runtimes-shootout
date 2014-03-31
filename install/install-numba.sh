#! /bin/sh

# v0.11.0, latest stable as of 2013-09-26
NUMBA=a1f09db06c38e383299e2118df5f211c6cd73e7d
LLVM=3.3
# v0.12.0, latest release as of 2013-09-26
LLVMPY=af2c1d6d0149f68101cb9c7a859ba6b410a942ba
#LLVMPY=2415042a2a07e99b24ab6859edb4d5d341ad5ea6 # v0.11.3, latest release as of 2013-08-12

sw=$HOME/sw
set -ex


# setup a virtualenv to host Numba and related packages
virtualenv numba-numba-$(echo ${NUMBA} | cut -c1-7)
. numba-numba-$(echo ${NUMBA} | cut -c1-7)/bin/activate


# Install LLVM
# ------------
# see https://github.com/llvmpy/llvmpy for the most up-to-date instructions.
#
wget http://llvm.org/releases/${LLVM}/llvm-${LLVM}.src.tar.gz
tar zxvf llvm-${LLVM}.src.tar.gz
cd llvm-${LLVM}.src

./configure --enable-optimized --prefix=${sw}
# Be sure your compiler architecture is same as version of Python you will use
#  e.g. -arch i386 or -arch x86_64.  It might be best to be explicit about this.
env REQUIRES_RTTI=1 make install


# Install llvmpy
# ------------
# see https://github.com/llvmpy/llvmpy for the most up-to-date instructions.
#
# Morally, it's git clone https://github.com/llvmpy/llvmpy
#
wget https://github.com/llvmpy/llvmpy/tarball/${LLVMPY}/llvmpy-${LLVMPY}.tar.gz \
    -O - | tar -xz
cd llvmpy-llvmpy-$(echo ${LLVMPY} | cut -c1-7)
env LLVM_CONFIG_PATH=${sw}/bin/llvm-config python setup.py install


# Install Numba
# -------------
# Morally, it's: git clone https://github.com/numba/numba.git
#
wget https://github.com/numba/numba/tarball/${NUMBA}/numba-${NUMBA}.tar.gz \
    -O - | tar -xz
cd numba-numba-$(echo ${NUMBA} | cut -c1-7)

# for some reason, NumPy and Cython fail if installed from requirements.txt
pip install cython
pip install numpy

# install
pip install -r requirements.txt
python setup.py build_ext --inplace
python setup.py install
