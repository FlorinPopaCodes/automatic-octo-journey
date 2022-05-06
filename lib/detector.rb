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
    check
  end

  def count
    run.count
  end

  private

  attr_writer :radar_sample, :invaders, :specificity, :possible_invaders

  def check
    check_invaders do |invader|
      check_radar do |x, y|
        add_possible_invaders_from_top_part(invader, x, y)
        add_possible_invaders_from_bottom_part(invader, x, y)

        add_possible_invaders(invader, x, y)
      end
    end

    possible_invaders
  end

  def check_invaders
    invaders.each do |invader|
      yield invader
    end
  end

  # TODO: improve to skip over already detected invaders.
  def check_radar
    radar_sample.matrix.height.times do |x|
      radar_sample.matrix.width.times do |y|
        yield x, y
      end
    end
  end

  def add_possible_invaders_from_top_part(invader, x, y)
    return unless radar_sample.matrix.top_part?(x)

    invader.top_varieties.each do |invader_variety|
      if invader_variety.compare_with_submatrix(radar_sample.matrix, x, y) > specificity
        possible_invaders << [x, y]
        break
      end
    end
  end

  def add_possible_invaders_from_bottom_part(invader, x, y)
    return unless radar_sample.matrix.bottom_part?(x, adjustment: invader.height / 2)
    invader.bottom_varieties.each do |invader_variety|
      if invader_variety.compare_with_submatrix(radar_sample.matrix, x, y) > specificity
        possible_invaders << [x, y]
        break
      end
    end
  end

  def add_possible_invaders(invader, x, y)
    possible_invaders << [x, y] if invader.matrix.compare_with_submatrix(radar_sample.matrix, x, y) > specificity
  end
end
