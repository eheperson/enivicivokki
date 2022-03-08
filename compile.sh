apt-get install cowsay
cowsay "hello motherfucker"


# -----------------------------------
#       CONFIGURE
# -----------------------------------
echo ""
echo " Configure Begin"
echo ""

# cmake -G "MinGW Makefiles" -S . -B ./build
cmake -S . -B ./build

echo ""
echo " Configure End"
echo ""

# -----------------------------------
#       BUILD
# -----------------------------------
buildDIR="./build"
if [ ! -d "$DIR" ]; then
  mkdir ${DIR}
fi

echo ""
echo " Build Begin"
echo ""

cd build
cmake --build .
# or 
# mingw32-make
cd ..

echo ""
echo " Build End"
echo ""
