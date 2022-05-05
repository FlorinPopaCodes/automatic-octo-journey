class Detector
  attr_accessor :radar_sample, :invaders

  def initialize(radar_sample, invaders: [])
    self.radar_sample = radar_sample
    self.invaders = invaders
  end

  def run
    radar_matrix = radar_sample.matrix

    radar_matrix_height = radar_matrix.size
    radar_matrix_weight = radar_matrix.first.size

    possible_invaders = []

    radar_matrix_height.times do |x|
      radar_matrix_weight.times do |y|

        invaders.each do |invader|
          hits = 0
          checks = 0

          invader.shape.each_with_index do |shape_line, shape_line_index|
            shape_line.each_with_index do |shape_char, shape_char_index|
              next unless radar_matrix[x + shape_line_index] && radar_matrix[x + shape_line_index][y + shape_char_index]
              checks += 1

              if shape_char == radar_matrix[x + shape_line_index][y + shape_char_index]
                hits += 1
              end
            end
          end

          # if hits is at least half of checks, then we have a match
          if hits == checks
            possible_invaders << [x, y, hits.to_f / checks, invader.name]
          end
        end

      end
    end

    possible_invaders
  end

  def count
    run.count
  end
end
