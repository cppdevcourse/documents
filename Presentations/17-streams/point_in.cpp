#include <iostream>
struct Point {
    int x {};
    int y {};
};
std::istream& operator>>(std::istream& in,
                         Point& p) {
    in >> p.x >> p.y;
    return in;
}
int main() {
    Point p {};
    std::cin >> p;
    std::cout << p.x << ' ' << p.y << '\n';
}
