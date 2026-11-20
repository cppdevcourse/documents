#include <print>
#include <string>

int main() {
    std::string a = "C++";
    std::string b(5, '*');
    std::string c = a;
    std::string d = std::move(c);
    std::println("{} {} {}", a, b, d);
}
