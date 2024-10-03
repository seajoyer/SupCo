#pragma once

#include "vector3d_structure.h"

class DynamicMatrix {
private:
    Vector3D** matrix;
    size_t rows;
    size_t cols;

    void allocateMemory();
    void deallocateMemory();

public:
    DynamicMatrix(size_t rows, size_t cols);
    ~DynamicMatrix();

    // Rule of Three (since we're managing raw pointers)
    DynamicMatrix(const DynamicMatrix& other);
    DynamicMatrix& operator=(const DynamicMatrix& other);

    // Element access and modification
    Vector3D& at(size_t row, size_t col);
    const Vector3D& at(size_t row, size_t col) const;

    // Matrix operations
    void deleteRow(size_t row);
    void deleteColumn(size_t col);
    void addRow(const Vector3D* newRow);
    void addColumn(const Vector3D* newColumn);
    void insertSubmatrix(const DynamicMatrix& submatrix, size_t startRow, size_t startCol);

    // Basic matrix operations
    DynamicMatrix operator+(const DynamicMatrix& other) const;
    DynamicMatrix operator-(const DynamicMatrix& other) const;
    DynamicMatrix operator*(const DynamicMatrix& other) const;
    DynamicMatrix operator*(double scalar) const;

    // Utility functions
    size_t getRows() const { return rows; }
    size_t getCols() const { return cols; }
    void print() const;
};
