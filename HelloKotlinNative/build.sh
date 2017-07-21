#!/usr/bin/env bash

rm -rf build
mkdir build
cd src
kotlinc main.kt -o ../build/HelloKotlin
