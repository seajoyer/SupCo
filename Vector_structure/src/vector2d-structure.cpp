#include "vector2d-structure.h"

#include <cmath>
#include <iostream>

Vector2D::Vector2D(double x, double y) : x(x), y(y) {}

Vector2D Vector2D::operator+(const Vector2D &other) const {
    return Vector2D(x + other.x, y + other.y);
}

Vector2D Vector2D::operator-(const Vector2D &other) const {
    return Vector2D(x - other.x, y - other.y);
}

Vector2D Vector2D::operator*(const double scalar) const {
    return Vector2D(x * scalar, y * scalar);
}

double Vector2D::operator*(const Vector2D &other) const {
    return x * other.x + y * other.y;
}

Vector2D Vector2D::operator/(const double scalar) const {
    if (scalar == 0)
        throw std::invalid_argument("Zero division!");
    return Vector2D(x / scalar, y / scalar);
}

Vector2D& Vector2D::operator+=(const Vector2D &other) {
    x += other.x;
    y += other.y;
    return *this;
}

Vector2D& Vector2D::operator-=(const Vector2D &other) {
    x -= other.x;
    y -= other.y;
    return *this;
}

Vector2D& Vector2D::operator*=(double scalar) {
    x *= scalar;
    y *= scalar;
    return *this;
}

Vector2D& Vector2D::operator/=(double scalar) {
    if (scalar == 0)
        throw std::invalid_argument("Zero division!");
    x /= scalar;
    y /= scalar;
    return *this;
}

Vector2D Vector2D::operator-() const {
    return Vector2D(-x, -y);
}

bool Vector2D::operator==(const Vector2D &other) const {
    return (x == other.x) && (y == other.y);
}

bool Vector2D::operator!=(const Vector2D &other) const {
    return !(*this == other);
}

double Vector2D::length() const {
    return sqrt(x*x + y*y);
}

Vector2D Vector2D::normalize() const {
    double len = length();
    if (len == 0)
        throw std::logic_error("Cant normalize a zero vector!");
    return *this / len;
}

std::ostream& operator<<(std::ostream& os, const Vector2D& vec) {
    os << "(" << vec.x << ", " << vec.y << ")";
    return os;
}
