@echo off
pushd ..
if exist build\ (
	mkdir build
	
) 
pop
cmake  . -B build/ --preset x86-debug
