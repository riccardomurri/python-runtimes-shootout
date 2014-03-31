#! /bin/sh

# latest commit as of 2013-08-12 -- BROKEN
#FALCON=9444f0f25feba186cef8fb2dc249aad331edd980

# latest commit as of 2013-08-19
#FALCON=dd15b9b972980707f3384e44e1b2a62178ab78f4

# latest commit as of 2013-09-26
FALCON=3e24e48bf8b05445cb735dabe66c52d3ef276111

set -ex


wget https://github.com/rjpower/falcon/tarball/${FALCON}/falcon-${FALCON}.tar.gz \
    -O - | tar -xz
cd rjpower-falcon-$(echo ${FALCON} | cut -c1-7)

# setup a virtualenv
virtualenv .
source bin/activate

# install falcon
python setup.py develop
