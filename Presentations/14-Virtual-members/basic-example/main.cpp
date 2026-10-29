void print(Employee* p) {
    p->Print();
}

int main() {
    Employee* p
        = new Employee {};
    // выведет "Sean"
    print(p);
    delete p;
    p = new Manager {};
    // выведет "Mike, 2"
    print(p);
    delete p;
}
