#! /bin/sh

PYPY=2.1


set -ex

have_command () { type "$1"; }


# download and extract
wget -N https://bitbucket.org/pypy/pypy/downloads/pypy-${PYPY}-src.tar.bz2
tar -xjf pypy-${PYPY}-src.tar.bz2
cd pypy-${PYPY}-src


# ensure dependencies are installed
if have_command aptitude; then
    sudo aptitude install \
        gcc make python-dev libffi-dev libsqlite3-dev pkg-config \
        libz-dev libbz2-dev libncurses-dev libexpat1-dev \
        libssl-dev libgc-dev python-sphinx python-greenlet
fi

# determine whether to build with PyPy or with Python
if have_command pypy-c; then
    py=pypy-c
else
    py=python
fi

# build the JIT version
cd pypy/goal/
$py ../../rpython/bin/rpython -Ojit targetpypystandalone
