require './lib/invaders/base_invader'

module Invaders
  class Squid < BaseInvader
    def self.shape
      <<~EOL
      ---oo---
      --oooo--
      -oooooo-
      oo-oo-oo
      oooooooo
      --o--o--
      -o-oo-o-
      o-o--o-o
      EOL
    end
  end
end
