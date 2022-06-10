//
// Created by kis on 24.05.22.
//

#include "Vec3.h"

#include <cmath>

Vec3::Vec3(float len) {
    x = y = z = std::sqrt((1.0f / 3.0f) * len);
}

Vec3::Vec3(float x, float y, float z) : x(x), y(y), z(z) {}

Vec3 &Vec3::operator+=(const Vec3 &b) {
    x += b.x;
    y += b.y;
    z += b.z;
    return *this;
}

Vec3 Vec3::operator*(float fac) const {
    return Vec3{x * fac, y * fac, z * fac};
}

Vec3 Vec3::operator-(const Vec3 &b) const {
    return Vec3{x - b.x, y - b.y, z - b.z};
}

void Vec3::normalize() {
    float l = 1 / norm();
    x *= l;
    y *= l;
    z *= l;
}

float Vec3::norm() const {
    return std::sqrt(x * x + y * y + z * z);
}

void Vec3::scale(float len) {
    normalize();
    *this *= len;
}

Vec3 &Vec3::operator*=(float l) {
    *this = *this * l;
    return *this;
}

Vec3 Vec3::operator/(float fac) const {
    return Vec3{x / fac, y / fac, z / fac};
}
