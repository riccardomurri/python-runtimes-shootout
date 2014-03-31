This repository hosts the code used to set up and run the benchmarks
of the FatGHoL_ code, as reported in the paper *Performance of Python
runtimes on a non-numeric scientific code*, presented at `EuroSciPy
2013`_.

.. _fatghol: http://fatghol.googlecode.com/

.. _`euroscipy 2013`: https://www.euroscipy.org/2013/


* The ``install`` directory contains scripts used to install the
  various runtimes.  They are known to run correctly on SLES12_, but
  should probably work on any other Linux distribution with minimal
  adaptation.

  .. _sles12: http://en.wikipedia.org/wiki/SUSE_Linux_Enterprise_Server

* The ``run`` directory contains the bash_ scripts used to run the
  tests.  They are quite specific to my setup, but again should be
  easy to adapt.

  .. _bash: https://www.gnu.org/software/bash/bash.html


All the code is publicly available under the GNU GPL v3 (or, at your
option, any later version); see the accompanying LICENSE_ file.

.. _LICENSE: LICENSE.txt
