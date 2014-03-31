#! /bin/sh

PYTHON=2.7.5


sw=$HOME/sw

# download and extract sources
wget -N http://www.python.org/ftp/python/${PYTHON}/Python-${PYTHON}.tar.bz2
tar -xjf Python-${PYTHON}.tar.bz2
cd Python-${PYTHON}

# build and install
./configure --prefix=${sw} "$@"
make
make install
