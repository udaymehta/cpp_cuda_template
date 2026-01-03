#!/bin/env bash

set -e

MODE=${1:-release}

if [[ "$MODE" == "debug" ]]; then
    BUILD_DIR="build-debug"
    CMAKE_TYPE="Debug"
elif [[ "$MODE" == "release" ]]; then
    BUILD_DIR="build-release"
    CMAKE_TYPE="Release"
else
    echo "Error: Invalid argument. Use 'debug' or 'release'."
    exit 1
fi

# Ninja (speed voooooooo!)
if [ ! -f "$BUILD_DIR/build.ninja" ]; then
    echo "Configuring $CMAKE_TYPE build with Ninja..."
    cmake -S . -B "$BUILD_DIR" -DCMAKE_BUILD_TYPE="$CMAKE_TYPE" -G Ninja
fi

# Makefile (default)
# if [ ! -f "$BUILD_DIR/Makefile" ] && [ ! -f "$BUILD_DIR/build.ninja" ]; then
#     echo "Configuring $CMAKE_TYPE build..."
#     cmake -S . -B "$BUILD_DIR" -DCMAKE_BUILD_TYPE="$CMAKE_TYPE"
# fi

echo "Building ($CMAKE_TYPE)..."
cmake --build "$BUILD_DIR" -j$(nproc)

ln -sf "$BUILD_DIR/compile_commands.json" .

EXECUTABLE="./$BUILD_DIR/bin/cpp_template"

if [ -f "$EXECUTABLE" ]; then
    "$EXECUTABLE"
else
    echo "Error: Binary not found at $EXECUTABLE"
fi
