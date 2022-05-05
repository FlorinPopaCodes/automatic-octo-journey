require './lib/matrix_similarity'

class Detector
  attr_accessor :radar_sample, :invaders, :specificity, :possible_invaders

  # Specificity was selected by trial and error.
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
            possible_invaders << [x, y, similarity, invader]
          end
        end
      end
    end

    if ENV['DEBUG'] == 'true'
      map_of_possible_invaders = Array.new(radar_matrix.height) do
        Array.new(radar_matrix.width) do
          '-'
        end
      end

      possible_invaders.each do |x, y, _, invader|
        map_of_possible_invaders[x..x + invader.height - 1].each_with_index do |line, i|
          line[y..y + invader.width - 1] = invader.matrix.matrix[i]
        end
      end

      map_of_possible_invaders.each do |line|
        puts line.join
      end
    end

    possible_invaders
  end

  def count
    run.count
  end
end
