require './lib/matrix_similarity'
require './lib/matrix'

RSpec.describe MatrixSimilarity do
  context "when comparing two similar matrices" do
    let(:matrix_a) { Matrix.from_string("11\n11") }

    subject(:matrix_similarity) { described_class.new(matrix_a, matrix_a) }

    it "compares two matrices of equal dimensions and returns the similarity score" do
      expect(matrix_similarity.compare).to be_a(Float)
      expect(matrix_similarity.compare).to be_between(0.0, 1.0)
      expect(matrix_similarity.compare).to eq(1.0)
    end
  end

  context "when comparing two completely different matrices" do
    let(:matrix_a) { Matrix.from_string("11\n11") }
    let(:matrix_b) { Matrix.from_string("22\n22") }

    subject(:matrix_similarity) { described_class.new(matrix_a, matrix_b) }

    it "compares two matrices of equal dimensions and returns the similarity score" do
      expect(matrix_similarity.compare).to eq(0)
    end
  end

  context "when comparing two different matrices" do
    let(:matrix_a) { Matrix.from_string("11\n11") }
    let(:matrix_b) { Matrix.from_string("11\n21") }

    subject(:matrix_similarity) { described_class.new(matrix_a, matrix_b) }

    it "compares two matrices of equal dimensions and returns the similarity score" do
      expect(matrix_similarity.compare).to eq(0.75)
    end
  end
end
