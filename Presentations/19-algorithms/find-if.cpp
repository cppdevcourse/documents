#include <algorithm>
#include <array>
#include <print>

bool is_even(int i) {
    return i % 2 == 0;
}

int main() {
    std::array<int, 5> a {1, 3, 4, 7, 9};
    auto it = std::find_if(a.begin(), a.end(), is_even);
    if (it != a.end()) {
        std::println("first even: {}", *it);
    }
}
