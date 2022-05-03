require './lib/detector'
require './lib/radar_sample'
require './lib/invaders/squid'
require './lib/invaders/crab'

RSpec.describe Detector do
  let(:invaders) do
    [
      Invaders::Squid,
      Invaders::Crab
    ]
  end

  subject(:detector) { described_class.new(RadarSample, invaders: invaders) }

  it "finds at least an invader" do
      expect(detector.run.count).to be > 0
  end
end
