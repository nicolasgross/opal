clang -shared -fpic -I/usr/lib/jvm/java/include/ -I/usr/lib/jvm/java/include/linux/ -o libtainttest.so -target x86_64-linux-gnu ../TaintTest.c
clang -S -I/usr/lib/jvm/java/include/ -I/usr/lib/jvm/java/include/linux/ -emit-llvm -target x86_64-linux-gnu ../TaintTest.c
