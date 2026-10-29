#include <iostream>
using std::cout;

struct Base { int a; };

struct Derived : Base { int b; };

int main() {
    Derived d {}; Base* p = &d;
    auto* q = &p->a;
    cout << &d << '\n';
    cout << q << '\n';
    cout << &d.b << '\n';
}
