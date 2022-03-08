#!/bin/bash

apt-get install cowsay
cowsay "hello motherfucker"

rootDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

buildDIR="${rootDir}/build"
installDIR="${rootDir}/app"

# delete and re-create build directory at every time
if [ ! -d ${buildDIR} ]; then
  mkdir ${buildDIR}
else
  rm -r ${buildDIR}
  mkdir ${buildDIR}
fi

# delete and re-create install directory at every time
if [ ! -d ${installDIR} ]; then
  mkdir ${installDIR}
else
  rm -r ${installDIR}
  mkdir ${installDIR}
fi

# # create build dir if dows not exists
# if [ ! -d ${buildDIR} ]; then
#   mkdir ${buildDIR}
# fi

# # create install dir if dows not exists
# if [ ! -d ${installDIR} ]; then
#   mkdir ${installDIR}
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

# -----------------------------------
#       INSTALL
# -----------------------------------
echo ""
echo " Install Begin"
echo ""
#
cd ${buildDIR}
cmake --install . --prefix ${installDIR}
cd ${rootDir}
#
echo ""
echo " Install End "
echo ""

# -----------------------------------
#       TEST
# -----------------------------------
echo ""
echo " Test Begin"
echo ""
#
cd ${buildDIR}
ctest -C Debug -VV
#ctest -C Release -VV
# -N : will display the list of tests but not actually run them.
# -C : to specify the configuration type
#
#   For more information, check the CMake Documentation or run:
            # cmake --help-command enable_testing
            # cmake --help-command add_test
            # cmake --help-property "<CONFIG>_POSTFIX"
            # cmake --help-command set_property
cd ${rootDir}
#
echo ""
echo " Test End "
echo ""