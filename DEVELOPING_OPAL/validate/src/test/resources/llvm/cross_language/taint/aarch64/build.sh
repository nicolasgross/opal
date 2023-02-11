clang -shared -fpic -I/usr/lib/jvm/java/include/ -I/usr/lib/jvm/java/include/linux/ -o libtainttest.so -target aarch64v8a-linux ../TaintTest.c
clang -S -I/usr/lib/jvm/java/include/ -I/usr/lib/jvm/java/include/linux/ -emit-llvm -target aarch64v8a-linux ../TaintTest.c
