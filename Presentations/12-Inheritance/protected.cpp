#include <print>

struct Base {
    int a;
protected:
    int b;
};
struct Derived : Base {
    Derived() { a = 1; b = 2; }
    int GetB() { return b; }
};

int main() {
    Derived d;
    std::println("a = {}, b = {}", d.a, d.GetB());
    // std::println("b = {}", d.b);  // ошибка
}
