void bar();

void foo() {
    [[maybe_unused]]
    volatile int a
     = -1;
}

int main() {
    bar();
}
