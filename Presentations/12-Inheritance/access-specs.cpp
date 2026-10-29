struct Base {
    int a;
protected:
    int b;
private:
    int c;
};

struct D1 : public Base {};  // public
struct D2 : Base {};         // struct: public
class D3 : Base {};          // class: private
class D4 : public Base {};
