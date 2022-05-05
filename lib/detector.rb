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

              if bottom_part_of_invader.compare_with_submatrix(radar_matrix, x, y) > specificity
                possible_invaders << [x, y]
                break
              end
            end
          elsif x == radar_matrix.height - invader.height / 2 - 1
            1.upto(invader.height / 2) do |i|
              top_part_of_invader = invader.matrix.top_part(skip_lines: i)

              if top_part_of_invader.compare_with_submatrix(radar_matrix, x, y) > specificity
                possible_invaders << [x, y]
                break
              end
            end
          end

          possible_invaders << [x, y] if invader.matrix.compare_with_submatrix(radar_matrix, x, y) > specificity
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
