#include <fstream>
#include <iostream>
int main() {
    std::fstream io {"count.txt",
        std::ios_base::in | std::ios_base::out};
    int n {};
    io >> n;
    io.seekg(0, std::ios_base::end);
    io << ' ' << n + 1;
    std::cout << n + 1 << '\n';
}
