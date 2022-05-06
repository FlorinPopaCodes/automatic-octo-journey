require './lib/matrix'

# Base class for all invaders
module Invaders
  class BaseInvader
    attr_reader :matrix

    def initialize
      @matrix = ::Matrix.from_string(self.class.shape)
    end

    def self.shape
      raise NotImplementedError, 'You must implement #shape'
    end

    def to_s
      self.class.shape
    end

    def name
      self.class.name.split('::').last
    end

    def height
      @matrix.height
    end

    def width
      @matrix.width
    end

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
