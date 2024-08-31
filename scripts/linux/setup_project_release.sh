#!/bin/bash

pushd ../..
if [ -d "./build" ]; then
	mkdir build
fi 
popd 
cmake  . -B build/ --preset linux-debug
