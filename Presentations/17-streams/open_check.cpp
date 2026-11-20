#include <fstream>
#include <iostream>
int main() {
    std::ofstream out {"new.txt"};
    std::cout << "ofstream: " << std::boolalpha
              << out.good() << '\n';
    std::ifstream in {"no-such.txt"};
    std::cout << "ifstream: " << std::boolalpha
              << in.good() << '\n';
}
