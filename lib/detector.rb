require './lib/matrix_similarity'

class Detector
  attr_accessor :radar_sample, :invaders, :specificity, :possible_invaders

  def initialize(radar_sample, invaders: [], specificity: 0.8)
    self.radar_sample = radar_sample.new
    self.invaders = invaders.map(&:new)
    self.specificity = specificity
    self.possible_invaders = []
  end

  def run
    radar_matrix = radar_sample.matrix

    radar_matrix.height.times do |x|
      radar_matrix.width.times do |y|

        invaders.each do |invader|
          submatrix = Matrix.submatrix_from_matrix(radar_matrix, x, y, invader.width, invader.height)
          similarity = ::MatrixSimilarity.new(invader.matrix, submatrix).compare

          if similarity > 0.8
            possible_invaders << [x, y, similarity, invader.name]
          end
        endq
      end
    end

    possible_invaders.sort_by { |x| -x[2] }
  end

  def count
    run.count
  end
end
