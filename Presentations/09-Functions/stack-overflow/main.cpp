void foo() {
    int arr[1000] = {0};
    if (arr[0]) {
    }
    foo();
}

int main() {
    foo();
}
