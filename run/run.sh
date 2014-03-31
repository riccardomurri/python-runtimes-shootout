#! /bin/sh

#PBS -N euroscipy13
#PBS -j oe
#PBS -m ae
#PBS -M riccardo.murri@uzh.ch

me=$(basename "$0")

sw=$HOME/sw/src
wd=$HOME/euroscipy2013

export PATH=$HOME/sw/bin:$PATH
export LD_LIBRARY_PATH=$HOME/sw/lib:$LD_LIBRARY_PATH
export LD_RUN_PATH=$HOME/sw/lib:$LD_RUN_PATH
export LD_LIBRARY_PATH=$HOME/sw/lib64:$LD_LIBRARY_PATH
export LD_RUN_PATH=$HOME/sw/lib64:$LD_RUN_PATH
export CPATH=$HOME/sw/include
export C_INCLUDE_PATH=$HOME/sw/include
export CPLUS_INCLUDE_PATH=$HOME/sw/include


# aux functions
die () {
    local rc="$1"
    shift

    echo 1>&2 "$me: ERROR: $@"
    exit $rc
}


# main loop

if [ $# -eq 0 ]; then
    set -- python
fi

for interp in "$@"; do

    python=${1}; shift

    # load interpreter
    case "$python" in
        cython-bare)
            . ${sw}/cython-0.19.1/bin/activate
            export PYTHON='python'
            src=cython-bare
            ;;

        cython-purepython)
            . ${sw}/cython-0.19.1/bin/activate
            export PYTHON='python'
            src=cython-purepython
            ;;

        falcon)
            . ${sw}/rjpower-falcon-9444f0f/bin/activate
            export PYTHON='python -m falcon'
            src=falcon
            ;;

        numba)
            . ${sw}/numba-numba-a0a05cf/bin/activate
            export PYTHON='python'
            src=numba
            ;;

        nuitka)
            #. ${sw}/kayhayen-Nuitka-6fcd0fa/bin/activate
            . ${sw}/kayhayen-Nuitka-701ed2a/bin/activate
            # compile with:
            #
            # > nuitka --exe --python-version=2.7 --recurse-all -j 1 --show-progress mgn.py
            #
            export PYTHON='python'
            src=nuitka
            ;;

        pypy*)
            export PYTHON=pypy-c
            src=pypy
            ;;

        python*|cpython)
            export PYTHON=python2.7
            src=py27
            ;;

        *)
            die 1 "Unknown Python interpreter '$python' - aborting."
            ;;
    esac

    mkdir -p "$wd/data"

    for mgn in 0,4 0,5 1,3 2,1; do
        for n in $(seq 1 9); do
            set -x
            cd "${wd}/fatghol.${src}"
            ./mgn.sh homology $mgn 2>&1 | tee "${wd}/data/M${mgn}.${src}.${n}.log"
            set +x
        done
    done

done
