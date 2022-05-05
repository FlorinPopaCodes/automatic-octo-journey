module Invaders
    class BaseInvader
      def self.shape
        SCAN
          .lines(chomp: true)
          .map do |line|
            line.split('')
          end
      end
    end
end
