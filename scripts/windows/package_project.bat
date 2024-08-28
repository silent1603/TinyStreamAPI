@echo off

pushd ../..
pushd build
cpack -G ZIP -C Release
popd
popd