#include <print>
#include "protected.hpp"

int main() {
  Derived d;
  std::println("a = {}, b = {}",
    d.a, d.GetB());
}
