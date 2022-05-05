# Compares two matrices of equal dimensions and returns the similarity score
class MatrixSimilarity
  def initialize(matrix_a, matrix_b)
    @matrix_a = matrix_a
    @matrix_b = matrix_b
  end

  def compare
    matches = 0
    comparisons = 0

    @matrix_a.height.times do |x|
      @matrix_a.width.times do |y|
        # TODO: This is a bit of a hack.
        return 0 unless @matrix_b[x] && @matrix_b[x][y]

        comparisons += 1
        if @matrix_a[x][y] == @matrix_b[x][y]
          matches += 1
        end
      end
    end

    matches.to_f / comparisons
  end
end
