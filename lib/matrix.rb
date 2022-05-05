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

  private

  def initialize(matrix = nil)
    @matrix = matrix || []
    @height = @matrix.size
    @width = @matrix.first.size
  end
end

