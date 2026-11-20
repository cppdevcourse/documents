#include <iostream>
unsigned int get_number();
unsigned int get_number() { return 42u; }

int main() {
    const int x = get_number();
    std::cout << x << std::endl;
}
