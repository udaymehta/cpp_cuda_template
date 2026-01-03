# C++23 & CUDA Template

A boilerplate repo for C++ and CUDA development on Linux.

## Requirements
* **Linux** (ofcourse)
* **CMake** (4.20)
* **CUDA Toolkit** (nvcc)
* **GCC/Clang**
* **Ninja** (Optional, but recommended for speed)

## Build Setup

1.  **Clone with Dependencies**
    You *must* use `--recursive` to download the external libraries. However, its your choice.
    ```bash
    git clone --recursive [https://github.com/yourusername/cpp-cuda-template.git](https://github.com/yourusername/cpp-cuda-template.git)
    cd cpp-cuda-template
    ```

2.  **Build & Run (Release Mode)**
    The script configures, builds, and runs the binary automatically.
    ```bash
    ./run.sh
    ```

3.  **Build & Run (Debug Mode)**
    Compiles with `-g -O0` for debugging.
    ```bash
    ./run.sh debug
    ```

### Adding New Libraries

1. **Submodule it:** `git submodule add <url> external/libname`
2. **Update Root/ CMake:** Add `add_subdirectory(external/libname)`
3. **Update Src/ CMake:** Add `target_link_libraries(${PROJECT_NAME} PRIVATE libname)`

### GPU Configuration

The project is currently set to detect your GPU architecture automatically (`native`).
If you need to target a specific architecture (e.g., Maxwell for MX130), edit `CMakeLists.txt`:

```cmake
set(CMAKE_CUDA_ARCHITECTURES "50") # 50 = Maxwell, 75 = Turing, 86 = Ampere

```

### License
MIT aka. do what ever you want :)
