#!/usr/bin/env bash

# Exit immediately if any command fails
set -e

echo "=== 1. Installing dependencies ==="
sudo apt update
sudo apt install -y build-essential cmake pkg-config \
  libasound2-dev libpulse-dev libx11-dev libxext-dev \
  libxrandr-dev libxcursor-dev libxi-dev libxkbcommon-dev \
  libwayland-dev libgbm-dev

echo "=== 2. Building and installing SDL3 ==="
if [ ! -d "SDL" ]; then
  git clone https://github.com/libsdl-org/SDL.git --depth 1
fi

cmake -S SDL -B build_sdl3 -DCMAKE_BUILD_TYPE=Release
cmake --build build_sdl3 --parallel
sudo cmake --install build_sdl3
sudo ldconfig

echo "=== 3. Compiling src/main.c ==="
gcc src/main.c -o test $(pkg-config --cflags --libs sdl3) -lm

echo "=== 4. Running test program ==="
./test

# This file failed.
# Error:
# CMake Error at cmake/macros.cmake:449 (message):
#  Couldn't find dependency package for XSCRNSAVER.  Please install the needed
#  packages or configure with -DSDL_X11_XSCRNSAVER=OFF
#
#  The full set of dependencies is available at
#  https://wiki.libsdl.org/SDL3/README-linux#build-dependencies
#
# Call Stack (most recent call first):
#  cmake/sdlchecks.cmake:535 (SDL_missing_dependency)
#  CMakeLists.txt:2080 (CheckX11)
#
# Resolving with install dependency then deleting and reinstalling an sld library idk:
# 
# sudo apt install -y libxss-dev
#
# rm -rf build_sdl3
# 
# cmake -S SDL -B build_sdl3 -DCMAKE_BUILD_TYPE=Release
#
# Failed again:
#
# Make Error at cmake/macros.cmake:449 (message):
#  Couldn't find dependency package for XTEST.  Please install the needed
#  packages or configure with -DSDL_X11_XTEST=OFF
#  The full set of dependencies is available at
#  https://wiki.libsdl.org/SDL3/README-linux#build-dependencies
# Call Stack (most recent call first):
#  cmake/sdlchecks.cmake:558 (SDL_missing_dependency)
#  CMakeLists.txt:2080 (CheckX11) 
#
# sudo apt install -y libxtst-dev libxrender-dev libxcomposite-dev
#
# rm -rf build_sdl3 && cmake -S SDL -B build_sdl3 -DCMAKE_BUILD_TYPE=Release
#
#
#
