require './lib/invaders/crab'

RSpec.describe Invaders::Crab do
  subject(:invader) { described_class.new }

  describe '.name' do
    it "returns the invader's name" do
      expect(invader.name).to eq('Crab')
    end
  end

  describe '.width' do
    it "returns the invader's width" do
      expect(invader.width).to eq(11)
    end
  end

  describe '.height' do
    it "returns the invader's height" do
      expect(invader.height).to eq(8)
    end
  end

  describe '.matrix' do
    it "returns the invader's shape" do
      expect(invader.matrix).to be_a(Matrix)
    end
  end
end
