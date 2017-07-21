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
echo "Compile cpp sources into llvm code"

clang++ -emit-llvm -c\
 ${CWD}/c/hello.cpp\
 ${CWD}/c/Hi.cpp
checkResult

cd ..
cd ..
cd src
echo "Compile kotlin app"
kotlinc main.kt -library ${CWD}/build/klib/callc.klib\
 -nativelibrary ${CWD}/build/nlib/Hi.bc\
 -nativelibrary ${CWD}/build/nlib/hello.bc\
   -o ../build/callcpp
checkResult

echo "Completed!"
