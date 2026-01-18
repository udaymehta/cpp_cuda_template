#!/bin/env bash

set -e

BINARY_NAME='cpp_template'

MAX_JOBS=6 

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

# Ninja by default (vrooooooooooo! )
if [ ! -f "$BUILD_DIR/build.ninja" ]; then
    echo "Configuring $CMAKE_TYPE build..."
    
    CMAKE_ARGS=""
    if command -v ccache &> /dev/null; then
        CMAKE_ARGS="$CMAKE_ARGS -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_COMPILER_LAUNCHER=ccache"
    fi

    cmake -S . -B "$BUILD_DIR" \
        -DCMAKE_BUILD_TYPE="$CMAKE_TYPE" \
        -G Ninja \
        $CMAKE_ARGS \
        -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
fi

echo "Building ($CMAKE_TYPE) with max $MAX_JOBS jobs..."

cmake --build "$BUILD_DIR" -j"$MAX_JOBS"

ln -sf "$BUILD_DIR/compile_commands.json" .

EXECUTABLE="./$BUILD_DIR/bin/$BINARY_NAME"

if [ -f "$EXECUTABLE" ]; then
    "$EXECUTABLE"
else
    echo "Error: Binary not found at $EXECUTABLE"
fi

