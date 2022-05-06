require './lib/matrix_similarity'
require './lib/submatrix_operations'

class Matrix
  include SubmatrixOperations

  attr_reader :height, :width, :matrix

  def self.from_string(string_matrix)
    parsed_string = string_matrix
      .lines(chomp: true)
      .map do |line|
        line.split('')
      end

    new(parsed_string)
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

  def compare(other)
    MatrixSimilarity.new(self, other).compare
  end

  def top_part?(position)
    position == 0
  end

  def bottom_part?(position, adjustment: 0)
    position == height - adjustment - 1
  end

  private

  def initialize(matrix = nil)
    @matrix = matrix || []
  end
end

