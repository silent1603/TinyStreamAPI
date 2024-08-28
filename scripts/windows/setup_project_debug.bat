@echo off
pushd ../..
if exist build\ (
	mkdir build
	
) 
popd
cmake  . -B build/ --preset x86-debug
