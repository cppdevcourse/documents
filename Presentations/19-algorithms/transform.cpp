#include <algorithm>
#include <array>
#include <print>

int square(int i) {
    return i * i;
}

int main() {
    std::array<int, 4> src {1, 2, 3, 4};
    std::array<int, 4> dst {};

    std::transform(src.begin(), src.end(),
                   dst.begin(), square);

    for (int i : dst) { std::print("{} ", i); }
    std::println();
}
