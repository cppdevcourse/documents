#include <string>

struct Employee {
    std::string name;
    double salary;
};
struct Manager : Employee {
    int level;
};

int main() {
    Manager m {};
    m.name = "Ivan";
    m.salary = 1000;
    m.level = 2;
}
