void foo1();
void foo2();
void foo3();
int main() {
    foo1();
    foo2(); // linkage error
    foo3(); // linkage error
}
