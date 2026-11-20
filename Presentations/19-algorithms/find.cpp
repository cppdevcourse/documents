#include <algorithm>
#include <array>
#include <print>

int main() {
    std::array<int, 5> a {1, 3, 4, 7, 9};

    auto it = std::find(a.begin(), a.end(), 7);

    if (it != a.end()) {
        std::println("found: {}", *it);
    }
}
