#! /bin/sh

CYTHON=0.19.1


sw=$HOME/sw
set -ex


# setup a virtualenv to host Cython and related packages
virtualenv cython-${CYTHON}
. cython-${CYTHON}/bin/activate

# install w/ pip
pip install cython==${CYTHON}
