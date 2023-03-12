clang -shared -fpic -I/usr/lib/jvm/java/include/ -I/usr/lib/jvm/java/include/linux/ -O0 -o libtainttest_O0.so -target aarch64v8a-linux ../TaintTest.c
clang -shared -fpic -I/usr/lib/jvm/java/include/ -I/usr/lib/jvm/java/include/linux/ -O2 -o libtainttest_O2.so -target aarch64v8a-linux ../TaintTest.c
clang -S -I/usr/lib/jvm/java/include/ -I/usr/lib/jvm/java/include/linux/ -emit-llvm -O0 -o TaintTest_O0.ll -target aarch64v8a-linux ../TaintTest.c
clang -S -I/usr/lib/jvm/java/include/ -I/usr/lib/jvm/java/include/linux/ -emit-llvm -O2 -o TaintTest_O2.ll -target aarch64v8a-linux ../TaintTest.c
