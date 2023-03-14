#!/usr/bin/env bash

# executed on 64-bit raspberry pi

target="aarch64-linux"

# gcc has no -target option as clang, check if gcc target matches script target
gcc_target=$(gcc -dumpmachine)
IFS='-'
read -ra target_comps <<< "$target" # split target at '-'
if [[ "$gcc_target" != *"${target_comps[0]}"* || "$gcc_target" != *"${target_comps[1]}"* ]]; then
  echo "gcc target $gcc_target does not match script target $target"
  exit
fi

# compiled LLVM IR is basically equivalent to x86_64
#clang-15 -S -I/usr/lib/jvm/default-java/include/ -I/usr/lib/jvm/default-java/include/linux/ -emit-llvm -O0 -o TaintTest_O0.ll -target "$target" ../TaintTest.c
#clang-15 -S -I/usr/lib/jvm/default-java/include/ -I/usr/lib/jvm/default-java/include/linux/ -emit-llvm -O2 -o TaintTest_O2.ll -target "$target" ../TaintTest.c

clang-15 -shared -fpic -I/usr/lib/jvm/default-java/include/ -I/usr/lib/jvm/default-java/include/linux/ -O0 -o libtainttest_clang_O0.so -target "$target" ../TaintTest.c
clang-15 -shared -fpic -I/usr/lib/jvm/default-java/include/ -I/usr/lib/jvm/default-java/include/linux/ -O2 -o libtainttest_clang_O2.so -target "$target" ../TaintTest.c

gcc -shared -fpic -I/usr/lib/jvm/default-java/include/ -I/usr/lib/jvm/default-java/include/linux/ -O0 -o libtainttest_gcc_O0.so ../TaintTest.c
gcc -shared -fpic -I/usr/lib/jvm/default-java/include/ -I/usr/lib/jvm/default-java/include/linux/ -O2 -o libtainttest_gcc_O2.so ../TaintTest.c
