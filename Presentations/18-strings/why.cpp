#include <print>
#include <string>

int main() {
    char a[] = "Ada";
    a[0] = 'E';
    std::println("{}", a);

    std::string s = "Ada";
    s = "Grace";
    std::println("{}", s);
}
