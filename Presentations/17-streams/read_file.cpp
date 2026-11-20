#include <fstream>
#include <iostream>
int main() {
    std::ifstream in {"data.txt"};
    int n {};
    while (in >> n) {
        std::cout << n << '\n';
    }
}
