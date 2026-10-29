#include <iostream>
#include <cstdlib>
int main() {
    const char* const myEnvVar = std::getenv("MY_ENV_VAR");
    if (myEnvVar != nullptr) {
        std::cout << "'MY_ENV_VAR'=" << myEnvVar << std::endl;
    } else {
        std::cerr << "'MY_ENV_VAR' not defined" << std::endl;
    }
}
