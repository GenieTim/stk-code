#!/bin/sh

cd "${0%/*}/.." || exit 2

mkdir cmake_build
cd cmake_build || exit 3

emcmake cmake .. \
  -DEMSCRIPTEN=ON \
  -DUSE_CRYPTO_OPENSSL=OFF \
  -DUSE_WIIUSE=OFF \
  -DBUILD_RECORDER=OFF \
  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON # \
  # || exit 4

# remove some "unnecessary" libraries it tries to link
sed -i 's/\ \-lnul//g' "CMakeFiles/supertuxkart.dir/linklibs.rsp" 
sed -i 's/\ \-lNETTLE_LIBRARY\-NOTFOUND//g' "CMakeFiles/supertuxkart.dir/linklibs.rsp" 
sed -i 's/\ \-lLIBRESOLV_LIBRARY\-NOTFOUND//g' "CMakeFiles/supertuxkart.dir/linklibs.rsp" 
sed -i 's/\ \-lPTHREAD_LIBRARY\-NOTFOUND//g' "CMakeFiles/supertuxkart.dir/linklibs.rsp" 

emmake cmake --build . # || exit 5

emcc \
  --emscripten-cxx \
  @CMakeFiles/supertuxkart.dir/objects1.rsp \
  @CMakeFiles/supertuxkart.dir/linklibs.rsp \
  @CMakeFiles/supertuxkart.dir/includes_CXX.rsp \
  -o bin/supertuxkart.html


