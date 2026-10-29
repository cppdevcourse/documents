#include <print>
struct Base {
    void Print() { std::println("Base::Print"); }
};
struct Derived : Base {
    void Print() { std::println("Derived::Print"); }
};

void foo(Base& b) {
    b.Print();
}

int main() {
    Derived d;
    d.Print();  // выведет "Derived::Print"
    foo(d);     // выведет "Base::Print"
}
