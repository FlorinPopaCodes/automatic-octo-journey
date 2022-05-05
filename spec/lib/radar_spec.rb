require './lib/radar'

RSpec.describe Radar do
  let(:matrix) { described_class.matrix }

  it "build a matrix from the training data" do
    expect(matrix).to be_a(Array)
    expect(matrix.size).to eq(50)
    expect(matrix.first.size).to eq(100)
  end
end
