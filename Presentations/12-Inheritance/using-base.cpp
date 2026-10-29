#include <print>

struct Base {
    void Foo() { std::println("Foo()"); }
    void Foo(int) { std::println("Foo(int)"); }
};

struct Derived : Base {
    using Base::Foo;
    void Foo(double) { std::println("Foo(double)"); }
};

int main() {
    Derived d;
    d.Foo();    // Base::Foo()
    d.Foo(1);   // Base::Foo(int)
    d.Foo(1.0); // Derived::Foo(double)
}
