#include <iostream>
#include <sstream>
int main() {
    std::stringstream ss {"10 20"};
    int a {}, b {};
    ss >> a >> b;
    ss.clear();
    ss.str("");
    ss << "sum: " << a + b;
    std::cout << ss.str() << '\n';
}
