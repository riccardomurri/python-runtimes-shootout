#! /bin/sh

# v0.4.4.2, latest as of 2013-08-12
#NUITKA=6fcd0fa4a429dcdbd9a27ab3671b73c20d0da993
# v0.4.5.2, latest as of 2013-09-30
NUITKA=701ed2abc8effeb58884e33dde142d189917178c

sw=$HOME/sw
set -ex

# download and extract
wget https://github.com/kayhayen/Nuitka/tarball/${NUITKA}/falcon-${NUITKA}.tar.gz \
    -O - | tar -xz
cd kayhayen-Nuitka-$(echo ${NUITKA} | cut -c1-7)

# setup a virtualenv
virtualenv .
source bin/activate

# install nuitka
python setup.py build
python setup.py install --prefix=${sw}
