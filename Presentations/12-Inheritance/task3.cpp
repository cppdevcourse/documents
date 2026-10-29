#include <print>

struct Base {
    Base() { std::println("Base()"); }
    Base(int) { std::println("Base(int)"); }
};

struct Derived : Base {
    Derived(int) {}
};

int main() {
    Derived d {1};
}
