#! /bin/sh

VIRTUALENV=1.10.1

set -ex

wget --no-check-certificate -N https://pypi.python.org/packages/source/v/virtualenv/virtualenv-${VIRTUALENV}.tar.gz
tar xvfz virtualenv-${VIRTUALENV}.tar.gz
cd virtualenv-${VIRTUALENV}

ln -sv $(pwd)/virtualenv.py $HOME/sw/bin/virtualenv
