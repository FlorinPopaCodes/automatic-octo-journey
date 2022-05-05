require './lib/radar'

RSpec.describe Radar do
  let(:radar) { described_class.new }

  it "build a matrix from the training data" do
    expect(radar.matrix).to be_a(Matrix)
    expect(radar.height).to eq(50)
    expect(radar.width).to eq(100)
  end
end
