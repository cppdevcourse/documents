#include <fstream>
int main() {
    std::ofstream out {"data.txt"};
    out << "1 2 3" << '\n';
}
