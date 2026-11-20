#include <stdfloat> // C++23
#include <cstdint>

int main() {
    std::float16_t f = 2;       // 0100 0000 0000 0000
    f + f;                      // 0100 0100 0000 0000

    std::uint16_t u = 16384;    // 0100 0000 0000 0000
    u + u;                      // 1000 0000 0000 0000
}
