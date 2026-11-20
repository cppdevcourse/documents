#include <print>
#include <string>

int main() {
    std::string s = "🚀hi";
    std::println("bytes: {}", s.size());
    for (unsigned char c : s) {
        std::print("{:02x} ", c);
    }
    std::println();
}
