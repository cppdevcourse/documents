#include <algorithm>
#include <array>
#include <print>

int main() {
    std::array<int, 5> a {4, 1, 3, 2, 5};
    std::sort(a.begin(), a.end());
    for (int i : a) { std::print("{} ", i); }
    std::println();
}
