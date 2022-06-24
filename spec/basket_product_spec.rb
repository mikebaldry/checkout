RSpec.describe BasketProduct do
  let(:product) { Product.new(code: 'A', price: 15) }

  subject { described_class.new(product: product, quantity: 2) }

  describe '#code' do
    it 'returns the product code' do
      expect(subject.code).to eq(product.code)
    end
  end

  describe '#price' do
    it 'returns the product price minus any discounts applied' do
      expect(subject.price).to eq(15)
      expect(subject.discounted_by(10).price).to eq(5)
    end
  end

  describe '#sub_total' do
    it 'returns the price multiplied by the quantity' do
      expect(subject.sub_total).to eq(30)
      expect(subject.discounted_by(10).sub_total).to eq(10)
    end
  end

  describe '#discounted_by' do
    it 'returns another BasketProduct with a discount amount applied' do
      expect(subject.discounted_by(1).price).to eq(14)
      expect(subject.discounted_by(5).price).to eq(10)
    end
  end

  describe '#<=>' do
    it 'compares correctly' do
      expect(described_class.new(product: product, quantity: 2, discount: 50)).to eq(described_class.new(product: product, quantity: 2, discount: 50))
      expect(described_class.new(product: product, quantity: 1, discount: 50)).to_not eq(described_class.new(product: product, quantity: 2, discount: 50))
      expect(described_class.new(product: product, quantity: 2, discount: 25)).to_not eq(described_class.new(product: product, quantity: 2, discount: 50))
    end
  end
end