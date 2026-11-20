#include <algorithm>
#include <array>
#include <print>

int main() {
    std::array<int, 4> a {1, 2, 3, 4};
    std::reverse(a.begin(), a.end());
    for (int i : a) { std::print("{} ", i); }
    std::println();
}
