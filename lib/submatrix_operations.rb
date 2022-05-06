module SubmatrixOperations
  module ClassMethods
    def submatrix_from_matrix(matrix, x, y, width, height)
      new(matrix.matrix[x..x + height - 1].map do |line|
        line[y..y + width - 1]
      end)
    end
  end

  def bottom_part(skip_lines: 0)
    self.class.submatrix_from_matrix(self, skip_lines, 0, width, height - skip_lines)
  end

  def top_part(skip_lines: 0)
    self.class.submatrix_from_matrix(self, 0, 0, width, height - skip_lines)
  end

  def compare_with_submatrix(other, x, y)
    self.compare(
      self.class.submatrix_from_matrix(other, x, y, width, height)
    )
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end
