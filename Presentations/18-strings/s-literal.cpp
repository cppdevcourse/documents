#include <print>
#include <string>

using namespace std::literals::string_literals;

int main() {
    std::string s = "C++ "s + "23"s;
    std::println("{}", s);
}
