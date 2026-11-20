#include <algorithm>
#include <array>
#include <print>

int main() {
    std::array<int, 5> a {1, 2, 2, 3, 2};

    auto new_end =
        std::remove(a.begin(), a.end(), 2);

    for (auto it = a.begin(); it != new_end; ++it) {
        std::print("{} ", *it);
    }
    std::println();
    std::println("size: {}", a.size());
}
