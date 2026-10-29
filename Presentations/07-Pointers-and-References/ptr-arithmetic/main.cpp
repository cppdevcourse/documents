#include <iostream>
#include <cstdint>
int main() {
    const std::uint64_t x {};
    const std::uint64_t* const p { &x };
    std::cout << "p = " << p << ", (p + 1) = "
        << (p + 1) << std::endl;
}
