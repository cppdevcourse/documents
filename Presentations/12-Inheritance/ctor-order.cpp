#include <print>

struct Base {
    Base() { std::println("Base"); }
    ~Base() { std::println("~Base"); }
};

struct Derived : Base {
    Derived() { std::println("Derived"); }
    ~Derived() { std::println("~Derived"); }
};

int main() {
    Derived d;
}
