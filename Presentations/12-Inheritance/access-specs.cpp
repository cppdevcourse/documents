struct Base {
    int a;
protected:
    int b;
private:
    int c;
};

struct D1 : public Base {};
struct D2 : Base {};
class D3 : public Base {};
class D4 : Base {};
