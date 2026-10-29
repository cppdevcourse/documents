#include <print>

struct A {
    A() { std::println("A()"); }
    ~A() { std::println("~A()"); }
};

struct B : A {
    B() { std::println("B()"); }
    ~B() { std::println("~B()"); }
};

int main() {
    B b[2];
}
