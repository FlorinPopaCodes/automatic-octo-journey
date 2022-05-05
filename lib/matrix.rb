require './lib/matrix_similarity'

class Matrix
  attr_reader :height, :width, :matrix

  def self.from_string(string_matrix)
    parsed_string = string_matrix
      .lines(chomp: true)
      .map do |line|
        line.split('')
      end

    new(parsed_string)
  end

  def self.submatrix_from_matrix(matrix, x, y, width, height)
    new(matrix.matrix[x..x + height - 1].map do |line|
      line[y..y + width - 1]
    end)
  end

  def [](x)
    @matrix[x]
  end

  def ==(other)
    @matrix == other.matrix
  end

  def height
    @matrix.size
  end

  def width
    @matrix.first.size
  end

  def bottom_part(skip_lines: 0)
    Matrix.submatrix_from_matrix(self, skip_lines, 0, width, height - skip_lines)
  end

  def top_part(skip_lines: 0)
    Matrix.submatrix_from_matrix(self, 0, 0, width, height - skip_lines)
  end

  def compare(other)
    MatrixSimilarity.new(self, other).compare
  end

  private

  def initialize(matrix = nil)
    @matrix = matrix || []
  end
end

