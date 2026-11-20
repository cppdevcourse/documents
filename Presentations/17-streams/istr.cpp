#include <iostream>
#include <sstream>
#include <string>
int main() {
    std::istringstream in {"42 hello"};
    int n {};
    std::string s {};
    in >> n >> s;
    std::cout << n << ' ' << s << '\n';
}
