@echo off

pushd ../..
pushd build
cmake --install . --config Release
popd
popd