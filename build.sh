#!/usr/bin/env bash


echo "Compiling..."

gcc src/main.c -o main $(pkg-config --cflags --libs sdl3) -lm


./main


