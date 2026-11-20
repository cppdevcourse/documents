#include <algorithm>
#include <array>
#include <print>

int main() {
    std::array<int, 5> a {};
    std::fill(a.begin(), a.end(), 7);
    for (int i : a) { std::print("{} ", i); }
    std::println();
}
