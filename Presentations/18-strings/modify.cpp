#include <print>
#include <string>

int main() {
    std::string s = "hello, world";
    std::println("{}", s.substr(7));
    s.replace(0, 5, "bye");
    std::println("{}", s);
    s.erase(4, 7);
    std::println("{}", s);
}
