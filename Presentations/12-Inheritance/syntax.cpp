#include <string>

struct Employee {
    std::string name;
    double salary;
};

struct Manager : Employee {
    int level;
};
