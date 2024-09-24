#include "test-vector2d.h"
#include "vector2d-structure.h"
#include <iostream>

void testVector2D() {
    std::cout << "Testing Vector2D structure..." << std::endl;
    std::cout << "-----------------------------" << std::endl;

    Vector2D v1(3, 4);
    Vector2D v2;
    std::cout << "v1 = " << v1 << ", v2 = " << v2 << std::endl;

    std::cout << std::endl;

    Vector2D v3 = v1 + v2;
    std::cout << "v1 + v2 = " << v3 << std::endl;

    v3 = v1 - v2;
    std::cout << "v1 - v2 = " << v3 << std::endl;

    double dot = v1 * v2;
    std::cout << "v1 * v2 = " << dot << std::endl;

    std::cout << std::endl;

    v3 = v1 * 2.5;
    std::cout << "v1 * 2.5 = " << v3 << std::endl;

    v3 = v1 / 2.0;
    std::cout << "v1 / 2.0 = " << v3 << std::endl;

    std::cout << std::endl;

    v3 = -v1;
    std::cout << "v3 = -v1 = " << v3 << std::endl;

    std::cout << std::endl;

    v3 += v1;
    std::cout << "v3 += v1 => " << v3 << std::endl;

    v3 -= v1;
    std::cout << "v3 -= v1 => " << v3 << std::endl;

    std::cout << std::endl;

    std::cout << "v1 = " << v1 << "; v2 = " << v2 << std::endl;
    std::cout << "v1 == v2? " << (v1 == v2) << std::endl;
    std::cout << "v1 != v2? " << (v1 != v2) << std::endl;

    std::cout << std::endl;

    std::cout << "Length of v1: " << v1.length() << std::endl;
    try {
        Vector2D normalized = v1.normalize();
        std::cout << "Normalized v1: " << normalized << std::endl;
    } catch (const std::logic_error& e) {
        std::cerr << "Error: " << e.what() << std::endl;
    }

    std::cout << "-----------------------------" << std::endl;
    std::cout << "Testing complete." << std::endl;
}
