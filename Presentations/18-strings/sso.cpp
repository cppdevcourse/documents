#include <print>
#include <string>

int main() {
    std::println("{}", sizeof(std::string));
    std::string s = "hi";
    std::println("{}: {}", s.size(), (void*)s.data());
    s += " this string is long enough for the heap";
    std::println("{}: {}", s.size(), (void*)s.data());
}
