struct Employee {
    /* ... */
    virtual void Print() {
        std::cout << name_
            << std::endl;
    }
};

struct Manager : Employee {
    /* ... */
    void Print() override {
        std::cout << name_
            << ", " << level_
            << std::endl;
    }
};
