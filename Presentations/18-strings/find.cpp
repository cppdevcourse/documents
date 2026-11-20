#include <print>
#include <string>

int main() {
    std::string s = "the quick brown fox";
    std::println("{}", s.find("fox"));
    std::println("{}", s.rfind("o"));
    std::println("{} {} {}",
        s.starts_with("the"),
        s.ends_with("fox"),
        s.contains("quick"));
}
