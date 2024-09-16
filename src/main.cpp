#include <cmath>
#include <iostream>
#include <Eigen/Core>

using namespace std;
using namespace Eigen;

template<typename T>
T mcheps(T init) {
    T eps = init;

    while (T(1.0) + eps > T(1.0))
        eps /= T(2.0);
    return eps;
}

template<typename T>
T mchdwarf(T init) {
    T dwarf = init;

    while (dwarf / T(2.0) != T(0.0))
        dwarf /= T(2.0);
    return dwarf;
}

template<typename T>
T mchgiant(T init) {
    T giant = init;

    while (giant * T(2.0) < T(INFINITY))
        giant *= T(2.0);
    return giant;
}

int main() {
    cout << string(25, '-') << endl;

    cout << "Single-precision (float):" << endl;
    cout << "  Epsilon:  " << mcheps<float>(1.0f)   << endl;
    cout << "  Dwarf:    " << mchdwarf<float>(1.0f) << endl;
    cout << "  Giant:    " << mchgiant<float>(1.0f) << endl;

    cout << endl;

    cout << "Double-precision (double):" << endl;
    cout << "  Epsilon:  " << mcheps<double>(1.0)   << endl;
    cout << "  Dwarf:    " << mchdwarf<double>(1.0) << endl;
    cout << "  Giant:    " << mchgiant<double>(1.0) << endl;

    cout << endl;

    cout << "Half-precision (Eigen::half):" << endl;
    cout << "  Epsilon:  " << mcheps<half>(half(1.0))   << endl;
    cout << "  Dwarf:    " << mchdwarf<half>(half(1.0)) << endl;
    cout << "  Giant:    " << mchgiant<half>(half(1.0)) << endl;
}
