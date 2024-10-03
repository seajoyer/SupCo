#pragma once

#include "vector3d_structure.h"
#include <cstddef>

class DynamicMatrix{
private:
    Vector3D** matrix;

    size_t rows;
    size_t cols;

    void   allocateMemory();
    void deallocateMemory();

public:
    DynamicMatrix(size_t rows, size_t cols);
    ~DynamicMatrix();

    size_t getRows() { return rows; }
    size_t getCols() { return cols; }
};
