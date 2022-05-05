require './lib/invaders/base_invader'

module Invaders
  class Crab < BaseInvader
    def self.shape
      <<~EOL
      --o-----o--
      ---o---o---
      --ooooooo--
      -oo-ooo-oo-
      ooooooooooo
      o-ooooooo-o
      o-o-----o-o
      ---oo-oo---
      EOL
    end
  end
end
