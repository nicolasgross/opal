#!/usr/bin/env bash

target="x86_64-linux"

# gcc has no -target option as clang, check if gcc target matches script target
gcc_target=$(gcc -dumpmachine)
IFS='-'
read -ra target_comps <<< "$target" # split target at '-'
if [[ "$gcc_target" != *"${target_comps[0]}"* || "$gcc_target" != *"${target_comps[1]}"* ]]; then
  echo "gcc target $gcc_target does not match script target $target"
  exit
fi

clang -S -I/usr/lib/jvm/java/include/ -I/usr/lib/jvm/java/include/linux/ -emit-llvm -O0 -o TaintTest_O0.ll -target "$target" ../TaintTest.c
clang -S -I/usr/lib/jvm/java/include/ -I/usr/lib/jvm/java/include/linux/ -emit-llvm -O2 -o TaintTest_O2.ll -target "$target" ../TaintTest.c

clang -shared -fpic -I/usr/lib/jvm/java/include/ -I/usr/lib/jvm/java/include/linux/ -O0 -o libtainttest_clang_O0.so -target "$target" ../TaintTest.c
clang -shared -fpic -I/usr/lib/jvm/java/include/ -I/usr/lib/jvm/java/include/linux/ -O2 -o libtainttest_clang_O2.so -target "$target" ../TaintTest.c

gcc -shared -fpic -I/usr/lib/jvm/java/include/ -I/usr/lib/jvm/java/include/linux/ -O0 -o libtainttest_gcc_O0.so ../TaintTest.c
gcc -shared -fpic -I/usr/lib/jvm/java/include/ -I/usr/lib/jvm/java/include/linux/ -O2 -o libtainttest_gcc_O2.so ../TaintTest.c
