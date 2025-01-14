#!/bin/bash

set -euo pipefail
source $(dirname $0)/var.sh

LIB_PATH=third_party/zlib
CXXFLAGS="-s USE_PTHREADS=1 $OPTIM_FLAGS"
CM_FLAGS=(
  -DCMAKE_INSTALL_PREFIX=$BUILD_DIR
  -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_FILE
  -DBUILD_SHARED_LIBS=OFF
  -DCMAKE_C_COMPILER_LAUNCHER=ccache
  -DCMAKE_CXX_COMPILER_LAUNCHER=ccache
)
echo "CM_FLAGS=${CM_FLAGS[@]}"

cd $LIB_PATH
rm -rf build zconf.h
mkdir -p build
cd build
emmake cmake .. -DCMAKE_C_FLAGS="$CXXFLAGS" ${CM_FLAGS[@]}
emmake make clean
emmake make install
cd $ROOT_DIR
