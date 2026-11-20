#include <algorithm>
#include <array>
#include <print>

int main() {
    std::array<int, 3> src {1, 2, 3};
    std::array<int, 3> dst {};

    std::copy(src.begin(), src.end(), dst.begin());

    for (int i : dst) { std::print("{} ", i); }
    std::println();
}
