@echo off
pushd ../..
pushd build
cmake --build . --config Release
popd
popd