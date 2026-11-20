#include <algorithm>
#include <print>
#include <vector>

int main() {
    std::vector<int> v {1, 2, 2, 3, 2};

    v.erase(std::remove(v.begin(), v.end(), 2),
            v.end());

    for (int i : v) { std::print("{} ", i); }
    std::println();
    std::println("size: {}", v.size());
}
