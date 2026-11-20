#include <print>
#include <string>

int main() {
    std::string s = "C++";
    std::println("{}", s.front());
    std::println("{}", s.back());
    s[0] = 'c';
    std::println("{}", s.at(1));
}
