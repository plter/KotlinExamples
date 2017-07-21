#!/usr/bin/env bash

CWD=`pwd`

function checkResult(){
    if [ $? -ne 0 ]; then
        exit
    fi
}

rm -rf build
mkdir build
cd build
mkdir klib
cd klib

echo "Generate kotlin lib with headers"
cinterop -def ${CWD}/def/callc.def -copt -I${CWD}/c -o callc
checkResult

cd ..
mkdir nlib
cd nlib
echo "Compile c sources into llvm code"
clang -c ${CWD}/c/hello.c -o hello.bc -emit-llvm
checkResult

cd ..
cd ..
cd src
echo "Compile kotlin app"
kotlinc main.kt -library ${CWD}/build/klib/callc.klib -nativelibrary ${CWD}/build/nlib/hello.bc -o ../build/callc
checkResult

echo "Completed!"
