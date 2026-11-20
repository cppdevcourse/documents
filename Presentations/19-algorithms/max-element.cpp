#include <algorithm>
#include <array>
#include <print>

int main() {
    std::array<int, 5> a {4, 1, 3, 2, 5};
    auto it = std::max_element(a.begin(), a.end());
    std::println("max: {}", *it);
}
