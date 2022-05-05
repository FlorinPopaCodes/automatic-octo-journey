require './lib/matrix'

RSpec.describe Matrix do
  subject(:matrix) { described_class.from_string(matrix_representation) }

  let(:matrix_representation) { "123\n456\n789\n147" }

  describe '.from_string' do
    it "builds a matrix from a string representation" do
      expect(matrix.matrix).to be_a(Array)
      expect(matrix.height).to eq(4)
      expect(matrix.width).to eq(3)
      expect(matrix.matrix).to eq([
        ['1', '2', '3'],
        ['4', '5', '6'],
        ['7', '8', '9'],
        ['1', '4', '7']
      ])
    end
  end

  describe '#[]' do
    it "returns the value at the given index" do
      expect(matrix[0]).to eq(['1', '2', '3'])
      expect(matrix[1]).to eq(['4', '5', '6'])
    end
  end

  describe '#submatrix_from_matrix' do
    it "returns a submatrix from the given matrix" do
      expect(described_class.submatrix_from_matrix(matrix, 0, 0, 3, 2)).to eq(
        Matrix.from_string("123\n456")
      )
    end


    it "returns a submatrix from the given matrix" do
      expect(described_class.submatrix_from_matrix(matrix, 1, 1, 2, 2)).to eq(
        Matrix.from_string("56\n89")
      )
    end
  end

  describe '#==' do
    it "returns true if the matrices are equal" do
      expect(matrix).to eq(matrix)
    end
  end

  describe '#compare' do
    it "returns the similarity between the two matrices" do
      expect(matrix.compare(matrix)).to eq(1)
    end
  end

  describe '#bottom_part' do
    it "returns the bottom part of the matrix" do
      expect(matrix.bottom_part(skip_lines: 2)).to eq(Matrix.from_string("789\n147"))
    end
  end

  describe '#top_part' do
    it "returns the top part of the matrix" do
      expect(matrix.top_part(skip_lines: 2)).to eq(Matrix.from_string("123\n456"))
    end
  end
end
