#include "dynamic_matrix.h"
#include "vector3d_structure.h"
#include <cstddef>
#include <iostream>
#include <stdexcept>
#include <cstring>

void DynamicMatrix::allocateMemory() {
    matrix = new Vector3D*[rows];
    for (size_t i = 0; i < cols; ++i) {
        matrix[i] = new Vector3D[cols];
    }
}

void DynamicMatrix::deallocateMemory() {
    for (size_t i = 0; i < rows; ++i) {
        delete[] matrix[i];
    }
    delete[] matrix;
}

DynamicMatrix::DynamicMatrix(size_t rows, size_t cols) : rows(rows), cols(cols) {
    allocateMemory();
}

DynamicMatrix::~DynamicMatrix() {
    deallocateMemory();
}
