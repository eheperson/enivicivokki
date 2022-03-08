#!/bin/bash

apt-get install cowsay
cowsay "hello motherfucker"

rootDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

buildDIR="${rootDir}/build"

# delete and re-create build directory at every time
if [ ! -d ${buildDIR} ]; then
  mkdir ${buildDIR}
else
  rm -r ${buildDIR}
  mkdir ${buildDIR}
fi

# # create build dir if dows not exists
# if [ ! -d ${buildDIR} ]; then
#   mkdir ${buildDIR}
# fi

# -----------------------------------
#       CONFIGURE
# -----------------------------------
echo ""
echo " Configure Begin "
echo ""
#
# cmake -G "MinGW Makefiles" -S . -B ./build
# cmake -DUSE_MYMATH=OFF -S . -B ./build 
cmake -DUSE_MYMATH=ON -S . -B ${buildDIR}
#
echo ""
echo " Configure End "
echo ""

# -----------------------------------
#       BUILD
# -----------------------------------
#
echo ""
echo " Build Begin "
echo ""
#
cd ${buildDIR}
cmake --build .
# or 
# mingw32-make
cd ${rootDir}
#
echo ""
echo " Build End "
echo ""
