#include <array>
#include <print>

template <class It>
It find_even(It beg, It end) {
    for (; beg != end; ++beg) {
        if (*beg % 2 == 0) {
            return beg;
        }
    }
    return end;
}

int main() {
    std::array<int, 5> a {1, 3, 4, 7, 9};
    auto it = find_even(a.begin(), a.end());
    if (it != a.end()) {
        std::println("first even: {}", *it);
    }
}
