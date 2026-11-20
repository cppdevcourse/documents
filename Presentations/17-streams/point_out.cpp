#include <iostream>
struct Point {
    int x {};
    int y {};
};
std::ostream& operator<<(std::ostream& out,
                         const Point& p) {
    out << "(" << p.x << ", " << p.y << ")";
    return out;
}
int main() {
    Point a {1, 2}, b {3, 4};
    std::cout << a << " -> " << b << '\n';
}
