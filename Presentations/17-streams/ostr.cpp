#include <iostream>
#include <sstream>
int main() {
    std::ostringstream out;
    out << "answer: " << 42;
    std::cout << out.str() << '\n';
}
