require './lib/invaders/squid'

RSpec.describe Invaders::Squid do
  subject(:invader) { described_class.new }

  describe '.name' do
    it "returns the invader's name" do
      expect(invader.name).to eq('Squid')
    end
  end

  describe '.width' do
    it "returns the invader's width" do
      expect(invader.width).to eq(8)
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
