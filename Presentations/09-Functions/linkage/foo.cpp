void foo1() {} // external linkage

[[maybe_unused]] static void foo2() {} // internal linkage

namespace {
[[maybe_unused]] void foo3() {} // internal linkage
}
