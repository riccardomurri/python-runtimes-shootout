#! /bin/sh

SWIG=2.0.8
PCRE=8.33


sw=$HOME/sw

have_command () { type "$1"; }


set -ex

wget -N http://downloads.sourceforge.net/project/swig/swig/swig-${SWIG}/swig-${SWIG}.tar.gz
tar -xzf swig-${SWIG}.tar.gz
cd swig-${SWIG}

# build PCRE (required dependency)
if ! have_command pcre-config; then
    wget -N ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PCRE}.tar.gz
    Tools/pcre-build.sh
fi

# build SWIG
./configure --prefix=${sw} \
    --with-python=${sw}/bin \
    --without-allegrocl \
    --without-chicken \
    --without-clisp \
    --without-csharp \
    --without-gcj \
    --without-guile \
    --without-java \
    --without-lua \
    --without-mzscheme \
    --without-ocaml \
    --without-octave \
    --without-perl5 \
    --without-php4 \
    --without-pike \
    --without-r \
    --without-ruby \
    --without-rxspencer \
    --without-tcl \
    "$@";
make
make install
