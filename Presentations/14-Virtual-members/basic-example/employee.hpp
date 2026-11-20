#include <iostream>
#include <string>

struct Employee {
    std::string name_ = "Sean";
    virtual ~Employee() = default;
    virtual void Print() {
        std::cout << name_
            << std::endl;
    }
};

struct Manager : Employee {
    int level_ = 2;
    Manager() { name_ = "Mike"; }
    void Print() override {
        std::cout << name_
            << ", " << level_
            << std::endl;
    }
};
