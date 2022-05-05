require './lib/invaders/base_invader'

module Invaders
  class Crab < BaseInvader
    SCAN = <<~EOL
    --o-----o--
    ---o---o---
    --ooooooo--
    -oo-ooo-oo-
    ooooooooooo
    o-ooooooo-o
    o-o-----o-o
    ---oo-oo---
    EOL

    def self.shape
      SCAN
        .lines(chomp: true)
        .map do |line|
          line.split('')
        end
    end
  end
end
