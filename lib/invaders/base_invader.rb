require './lib/matrix'

# Base class for all invaders
module Invaders
  class BaseInvader
    attr_reader :matrix, :width, :height

    def initialize
      @matrix = ::Matrix.from_string(self.class.shape)
      @height = @matrix.height
      @width = @matrix.width
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
  end
end
