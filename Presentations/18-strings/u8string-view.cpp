#include <print>
#include <string>
#include <string_view>

int main() {
    std::string s = "привет";
    std::u8string_view v{
        reinterpret_cast<const char8_t*>(s.data()),
        s.size()
    };
    int chars = 0;
    for (char8_t c : v)
        if ((c & 0xC0) != 0x80)
            ++chars;
    std::println("bytes: {} chars: {}", v.size(), chars);
}
