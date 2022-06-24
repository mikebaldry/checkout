RSpec.describe Rules::PercentageDiscountOnTotal do
  let(:product_a) { Product.new(code: 'A', price: 5) }
  let(:product_b) { Product.new(code: 'A', price: 2.50) }

  let(:value_15) { LineItem.new(product: product_a, quantity: 3) }
  let(:value_2_50) { LineItem.new(product: product_b, quantity: 1) }
  let(:value_5) { LineItem.new(product: product_b, quantity: 2) }
  let(:value_7_50) { LineItem.new(product: product_b, quantity: 3) }

  subject { described_class.new(minimum_total: 20.0, discount_percentage: 10.0) }

  describe '#apply' do
    context 'the total is less than the minimum total' do
      let(:line_items) { [value_15, value_2_50] }

      it 'does not apply discount' do
        expect(subject.apply(line_items)).to eq(line_items)
      end
    end

    context 'the total is exactly than the minimum total' do
      let(:line_items) { [value_15, value_5] }

      it 'applies the discount to all items' do
        discounted_15 = value_15.discounted_by(0.5) # 3 * 5, 10% of 5 = 0.5
        discounted_5 = value_5.discounted_by(0.25) # 2 * 2.5, 10% of 2.5 = 0.25

        expect(subject.apply(line_items)).to eq([discounted_15, discounted_5])
      end
    end

    context 'the total is above the minimum total' do
      let(:line_items) { [value_15, value_7_50] }

      it 'applies the discount to all items' do
        discounted_15 = value_15.discounted_by(0.5) # 3 * 5, 10% of 5 = 0.5
        discounted_7_50 = value_7_50.discounted_by(0.25) # 3 * 2.5, 10% of 2.5 = 0.25

        expect(subject.apply(line_items)).to eq([discounted_15, discounted_7_50])
      end
    end
  end
end
