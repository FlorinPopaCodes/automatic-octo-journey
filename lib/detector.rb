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
        versions_to_check = []

        if x == 0
          0.upto(invader.height / 2) do |i|
            versions_to_check << invader.matrix.bottom_part(skip_lines: i)
          end
        elsif x == radar_matrix.height - invader.height / 2 - 1
          1.upto(invader.height / 2) do |i|
            versions_to_check << invader.matrix.top_part(skip_lines: i)
          end
        else
          versions_to_check << invader.matrix
        end

        radar_matrix.width.times do |y|
          versions_to_check.each do |invader_version|
            similarity = Matrix
                .submatrix_from_matrix(radar_matrix, x, y, invader_version.width, invader_version.height)
                .compare(invader_version)

            if similarity > specificity
              possible_invaders << [x, y]
              break
            end
          end
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
