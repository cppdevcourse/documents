#include <print>

struct Base {
    Base() { std::println("Base()"); }
    Base(int) { std::println("Base(int)"); }
};

struct Derived : Base {
    Derived() : Base() {}
    Derived(int) : Base(42) {}
};
