struct Base {
  int a;
protected:
  int b;
};

struct Derived : Base {
  Derived() { a = 1; b = 2; }
  int GetB() { return b; }
};
