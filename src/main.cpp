#include <fmt/base.h>
#include <fmt/core.h>

#include <kernel.cuh>

int main() {
    fmt::print("Running standard C++ code... (printed from fmt lib)\n");

    launch_kernel();
}
