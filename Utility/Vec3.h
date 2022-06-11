//
// Created by kis on 24.05.22.
//

#ifndef GRAVITY_VEC3_H
#define GRAVITY_VEC3_H

struct Vec3 {
    float x, y, z;

    Vec3() = default;
    explicit Vec3 (float len);
    Vec3(float x, float y, float z);

    void normalize();
    void scale(float len);
    [[nodiscard]] float norm() const;

    Vec3& operator+=(const Vec3& b);
    Vec3& operator*=(float l);
    Vec3 operator-(const Vec3& b) const;
    Vec3 operator*(float fac) const;
    Vec3 operator/(float fac) const;
};


#endif //GRAVITY_VEC3_H
