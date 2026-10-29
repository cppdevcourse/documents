#include <print>

struct Base           { void Print() const { std::println("Base"); } };

struct Derived : Base { void Print() const { std::println("Derived"); } };

void foo(const Base b) { b.Print(); }

int main() {
    Derived d;
    d.Print();  // выведет "Derived"
    foo(d);     // выведет "Base"
}
