#pragma once

#include <ostream>

struct Vector2D {
    double x, y;

    Vector2D(double x = 0, double y = 0);

    Vector2D operator+(const Vector2D &other) const;
    Vector2D operator-(const Vector2D &other) const;
    Vector2D operator*(const double scalar) const;
    double operator*(const Vector2D &other) const;
    Vector2D operator/(const double scalar) const;
    Vector2D& operator+=(const Vector2D &other);
    Vector2D& operator-=(const Vector2D &other);
    Vector2D& operator*=(double scalar);
    Vector2D& operator/=(double scalar);
    Vector2D operator-() const;
    bool operator==(const Vector2D &other) const;
    bool operator!=(const Vector2D &other) const;
    double length() const;
    Vector2D normalize() const;
    friend std::ostream& operator<<(std::ostream& os, const Vector2D& vec);
};
