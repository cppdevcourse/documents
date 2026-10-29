#include <iostream>

void foo(double* p) { *p = 2.718; }

int main() {
    double d = 3.14;
    double* p = &d;
    foo(p);
    std::cout << "d=" << d << std::endl;
}
