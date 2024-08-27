@echo off

if exist build\ (
	mkdir build
	
) 
cmake  . -B build/ --preset x86-release
