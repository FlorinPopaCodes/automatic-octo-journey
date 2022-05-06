module Invaders
  module VarietyGenerators
    def top_varieties
      @top_varieties ||= (1..(height / 2)).map do |i|
        @matrix.bottom_part(skip_lines: i)
      end
    end

    def bottom_varieties
      @bottom_varieties ||= (1..(height / 2)).map do |i|
        @matrix.top_part(skip_lines: i)
      end
    end
  end
end
