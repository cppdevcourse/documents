#include <algorithm>
#include <print>
#include <vector>

bool is_even(int i) {
    return i % 2 == 0;
}

template <class C, class Pred>
void erase_if(C& c, Pred pred) {
    c.erase(std::remove_if(c.begin(), c.end(), pred),
            c.end());
}

int main() {
    std::vector<int> v {1, 2, 3, 4, 5, 6};
    erase_if(v, is_even);
    for (int i : v) { std::print("{} ", i); }
    std::println();
}
