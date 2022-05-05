require './lib/detector'
require './lib/radar'
require './lib/invaders/squid'
require './lib/invaders/crab'

RSpec.describe Detector do
  let(:invaders) do
    [
      Invaders::Squid,
      Invaders::Crab
    ]
  end

  subject(:detector) { described_class.new(Radar, invaders: invaders) }

  it "finds at least an invader" do
    expect(detector.run.count).to be > 0
  end

  it "finds all the obvious invaders" do
    expect(detector.run.count).to be >= 7
  end

  it "finds all the invaders including those at the edges" do
    expect(detector.run.count).to be >= 9
  end
end
