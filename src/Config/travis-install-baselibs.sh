#!/bin/sh
# source: mpi4py
# https://github.com/mpi4py/mpi4py/blob/master/conf/travis/install-mpi.sh

set -e

BASELIBS_VERSION="$1"
MPISTACK="$2"
COMPILER="$3"
os=`uname`


case "$BASELIBS_VERSION" in
4.0.11)
   if [ ! -d "${HOME}/local/Baselibs/${BASELIBS_VERSION}/${os}/bin" ]
   then
      ALLDIRS='jpeg zlib szlib curl hdf4 hdf5 h5edit netcdf netcdf-fortran udunits2 nccmp esmf'
      mkdir -p ${HOME}/Baselibs/src/ && cd ${HOME}/Baselibs/src/
      wget --no-check-certificate https://www.dropbox.com/s/fxbz31o82ihzfvg/ESMA-Baselibs-4.0.11.tar.gz
      tar xzf ESMA-Baselibs-4.0.11.tar.gz
      cd ESMA-Baselibs-4.0.11/src
      make -j2 install ESMF_COMM=$MPISTACK ESMF_COMPILER=$COMPILER --prefix=${HOME}/local/Baselibs/${BASELIBS_VERSION}/${os} ALLDIRS=$ALLDIRS
      cd ${HOME}
      exit 0
   else
      echo "Using cached ${BASELIBS_VERSION} directory";
      exit 0
   fi
   ;;
*)
   echo "Unknown MPI implementation: $BASELIBS_VERSION"
   exit 1
   ;;
esac
