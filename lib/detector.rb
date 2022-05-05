require './lib/matrix_similarity'

class Detector
  attr_reader :radar_sample, :invaders, :specificity, :possible_invaders

  # Specificity was selected by trial and error.
  def initialize(radar_sample, invaders: [], specificity: 0.8)
    self.radar_sample = radar_sample.new
    self.invaders = invaders.map(&:new)
    self.specificity = specificity
    self.possible_invaders = []
  end

  def run
    radar_matrix = radar_sample.matrix

    invaders.each do |invader|
      radar_matrix.height.times do |x|
        radar_matrix.width.times do |y|
          if x == 0
            1.upto(invader.height / 2) do |i|
              bottom_part_of_invader = invader.matrix.bottom_part(skip_lines: i)

              similarity = Matrix
                .submatrix_from_matrix(radar_matrix, x, y, bottom_part_of_invader.width, bottom_part_of_invader.height)
                .compare(bottom_part_of_invader)

              if similarity > specificity
                possible_invaders << [x-i, y, similarity, invader]
                break
              end
            end
          elsif x == radar_matrix.height - invader.height / 2 - 1
            1.upto(invader.height / 2) do |i|
              top_part_of_invader = invader.matrix.top_part(skip_lines: i)

              similarity = Matrix
                .submatrix_from_matrix(radar_matrix, x, y, top_part_of_invader.width, top_part_of_invader.height)
                .compare(top_part_of_invader)

              if similarity > specificity
                possible_invaders << [x, y, similarity, invader]
                break
              end
            end
          end

          submatrix = Matrix.submatrix_from_matrix(radar_matrix, x, y, invader.width, invader.height)
          similarity = invader.matrix.compare(submatrix)

          possible_invaders << [x, y, similarity, invader] if similarity > specificity
        end
      end
    end

    possible_invaders
  end

  def count
    run.count
  end

  private

  attr_writer :radar_sample, :invaders, :specificity, :possible_invaders
end
