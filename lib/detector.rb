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
      radar_sample.height.times do |x|
        radar_sample.width.times do |y|
          # Edge cases.
          if radar_matrix.top_part?(x)

            invader.top_varieties.each do |invader_variety|
              if invader_variety.compare_with_submatrix(radar_matrix, x, y) > specificity
                possible_invaders << [x, y]
                break
              end
            end
          elsif radar_matrix.bottom_part?(x, adjustment: invader.height / 2)

            invader.bottom_varieties.each do |invader_variety|
              if invader_variety.compare_with_submatrix(radar_matrix, x, y) > specificity
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
