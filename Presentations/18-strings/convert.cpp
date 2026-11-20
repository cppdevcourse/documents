#include <print>
#include <string>

int main() {
    std::println("{}", std::stoi("42"));
    std::println("{}", std::stod("3.14"));
    std::println("{}", std::stoul("FF", nullptr, 16));
    std::println("{}", std::to_string(100));
}
