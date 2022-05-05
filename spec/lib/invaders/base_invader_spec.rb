require './lib/invaders/base_invader'

RSpec.describe Invaders::BaseInvader do
  describe '#shape' do
    it 'raises NotImplementedError' do
      expect { described_class.shape }.to raise_error(NotImplementedError)
    end
  end

  context 'when the invader is a small circle' do
    before do
      allow(described_class).to receive(:shape).and_return("00\n00")
      allow(described_class).to receive(:name).and_return('Circle')
    end

    subject(:invader) { described_class.new }

    describe '.to_s' do
      it "returns the invader's shape" do
        expect(invader.to_s).to eq("00\n00")
      end
    end

    describe '.name' do
      it "returns the invader's name" do
        expect(invader.name).to eq('Circle')
      end
    end

    describe '.matrix' do
      it "returns the invader's shape" do
        expect(invader.matrix).to be_a(Matrix)
      end
    end

    describe '.width' do
      it "returns the invader's width" do
        expect(invader.width).to eq(2)
      end
    end

    describe '.height' do
      it "returns the invader's height" do
        expect(invader.height).to eq(2)
      end
    end
  end
end

