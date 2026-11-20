#include <print>
#include <string>

int main() {
    std::string s = "C++";
    s += " is fast";
    std::string t = "C++" + std::string(" is fast");
    std::println("{} {}", s == t, s < "C++ is faster");
}
