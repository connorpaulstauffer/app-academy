# Calculates and returns the inverse of the matrix
def inverse(matrix)
  det = determinant(matrix)
  return nil if det == 0 || det == nil
  factor = (1.0 / det)  
  if matrix.length == 2
    mat = clone_matrix(matrix)
    mat[0][0], mat[1][1] = mat[1][1], mat[0][0]
    mat[0][1], mat[1][0] = -mat[0][1], -mat[1][0]
  else
    mat = transpose(cofactor_matrix(matrix))
  end
  return multiply_constant(mat, factor)
end

# Calculates and returns the determinant of the matrix using Laplace expansion
def determinant(matrix)
  if !is_square?(matrix)
    return nil
  elsif matrix.length == 2
    return matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0]
  else
    sum = 0
    matrix[0].each_with_index do |n, i|
      value = n * determinant(cut_matrix(matrix, 1, i + 1))
      sum = (i % 2 == 0) ? sum + value : sum - value
    end
  end
  return sum
end

# Serializes an object and loads it back in to create a deep copy that breaks
# the chain of reference
def clone_matrix(matrix)
  return Marshal.load(Marshal.dump(matrix))
end

# Returns true if the matrix is square and false if it is not
def is_square?(matrix)
  n = matrix.length
  matrix.each do |row|
    return false if row.length != n
  end
  return true
end

# Returns the matrix with the given row and column removed
def cut_matrix(matrix, row, col)
  matr = clone_matrix(matrix)
  matr.delete_at(row - 1)
  matr.each do |r|
    r.delete_at(col - 1)
  end
  return matr
end

# Rounds each element of the matrix to the given number of decimal places
# or to the default number, two
def round_elements(matrix, figures = 2)
  mat = clone_matrix(matrix)
  mat.each do |row|
    row.map! do |element|
      element.round(figures)
    end
  end
  return mat
end

# Multiplies each element of the matrix by the given constant
def multiply_constant(matrix, constant)
  mat = clone_matrix(matrix)
  mat.each do |row|
    row.map! do |element|
      element * constant
    end
  end
  return mat
end

# Divides each element of the matrix by the given constant with float precision
def divide_constant(matrix, constant)
  mat = clone_matrix(matrix)
  constant = constant.to_f
  mat.each do |row|
    row.map! do |element|
      element / constant
    end
  end
  return mat
end

# Adds the given constant to each element of the matrix
def add_constant(matrix, constant)
  mat = clone_matrix(matrix)
  mat.each do |row|
    row.map! do |element|
      element + constant
    end
  end
  return mat
end

# Subtracts the given constant from each element of the matrix
def subtract_constant(matrix, constant)
  mat = clone_matrix(matrix)
  mat.each do |row|
    row.map! do |element|
      element - constant
    end
  end
  return mat
end

# Returns the i, j cofactor of the matrix
def cofactor(matrix, i, j)
  return (((-1) ** (i + j)) * determinant(cut_matrix(matrix, i, j)))
end

# Returns the matrix with the i, j cofactor in place of each i, j element
def cofactor_matrix(matrix)
  mat = clone_matrix(matrix)
  mat.each_with_index do |row, i|
    row.map!.with_index do |e, j|
      cofactor(clone_matrix(matrix), i + 1, j + 1)
    end
  end
  return mat
end

# Returns the transpose of the matrix
def transpose(matrix)
  matr = clone_matrix(matrix)
  mat = []
  0.upto(matr[0].length - 1) do |e|
    row = []
    matr.each do |r|
      row << r[e]
    end
    mat << row
  end
  return mat
end

# Multiplies the two matrices
def multiply(matrix1, matrix2)
  return false if matrix1.length != matrix2[0].length && matrix1[0].length != matrix2.length
  matrix2 = transpose(matrix2)
  mat = []
  matrix1.each do |row1|
    r = []
    matrix2.each do |row2|
      sum = 0
      row1.each_with_index do |e, j|
        sum += e * row2[j]
      end
      r << sum
    end
    mat << r
  end
  return mat
end
    
# Tests
puts "multiply(a, inverse(a)) == 4 x 4 identity matrix: " + (round_elements(multiply(
        [
          [2, 6, 4, 8],
          [8, 7, 9, 1],
          [2, 3, 5, 6],
          [8, 6, 5, 9]
        ] , inverse(
        [
          [2, 6, 4, 8],
          [8, 7, 9, 1],
          [2, 3, 5, 6],
          [8, 6, 5, 9]
        ] )), 0) ==
      [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
      ]
      ).to_s
      
puts "determinant(a) == -1170: " + (determinant(
    [
        [2, 6, 4, 8],
        [8, 7, 9, 1],
        [2, 3, 5, 6],
        [8, 6, 5, 9]
    ]
    ) == -1170).to_s   

puts "inverse(A) * B = x: " + (round_elements(multiply(inverse(
  [
    [1, 1, 1],
    [2, 0, 1],
    [5, -2, -3]
  ]), [[4], [0], [1]]), 0) == ([[1], [5], [-2]])).to_s
