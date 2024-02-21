#!/bin/bash

git submodule update --init
cd dpdk
git checkout 22.11
meson setup --prefix=$(pwd)/x86_64-native-linux-gcc x86_64-native-linux-gcc
ninja -C x86_64-native-linux-gcc
ninja -C x86_64-native-linux-gcc install
export RTE_SDK=$PWD
cd ..

export PKG_CONFIG_PATH=$(pwd)/dpdk/x86_64-native-linux-gcc/lib/x86_64-linux-gnu/pkgconfig/:$PKG_CONFIG_PATH
mkdir -p build
cd build
PKG_CONFIG_PATH=$PKG_CONFIG_PATH cmake ..
PKG_CONFIG_PATH=$PKG_CONFIG_PATH make -j