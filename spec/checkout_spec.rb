RSpec.describe Checkout do
  let(:promotional_rules) do
    [
      Rules::PriceDropOnMultiple.new(
        product_code: '001',
        minimum_quantity: 2,
        price: 8.50
      ),
      Rules::PercentageDiscountOnTotal.new(
        minimum_total: 60,
        discount_percentage: 10.0
      ),
    ]
  end

  let(:product_001) { Product.new(code: '001', name: 'Silver Earrings', price: 9.25) }
  let(:product_002) { Product.new(code: '002', name: 'Dove Dress in Bamboo', price: 45) }
  let(:product_003) { Product.new(code: '003', name: 'Autumn Floral Shirt', price: 19.95) }

  subject { described_class.new(promotional_rules) }

  it 'handles scenario 1' do
    subject.scan(product_001)
    subject.scan(product_002)
    subject.scan(product_003)

    expect(subject.total).to eq(66.78)
  end

  it 'handles scenario 2' do
    subject.scan(product_001)
    subject.scan(product_003)
    subject.scan(product_001)

    expect(subject.total).to eq(36.95)
  end

  it 'handles scenario 3' do
    subject.scan(product_001)
    subject.scan(product_002)
    subject.scan(product_001)
    subject.scan(product_003)

    expect(subject.total).to eq(73.76)
  end
end
