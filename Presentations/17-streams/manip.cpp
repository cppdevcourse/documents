#include <iomanip>
#include <iostream>
int main() {
    std::cout << std::setw(3) << 1 << ": "
              << std::fixed << std::setprecision(2)
              << 3.14159 << '\n';
}
