struct Base {
    int a;
    int b;
protected:
    int c;
private:
    int d;
};

struct Derived : Base {
    int Sum() { return a + b + c + d; }
};
