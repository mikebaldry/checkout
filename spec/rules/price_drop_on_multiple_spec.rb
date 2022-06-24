RSpec.describe Rules::PriceDropOnMultiple do
  let(:product_a) { Product.new(code: 'A', price: 15) }
  let(:product_b) { Product.new(code: 'B', price: 25) }

  let(:below_minimum) { BasketProduct.new(product: product_a, quantity: 3) }
  let(:exact_quantity) { BasketProduct.new(product: product_a, quantity: 4) }
  let(:above_minimum) { BasketProduct.new(product: product_a, quantity: 5) }
  let(:unrelated_product) { BasketProduct.new(product: product_b, quantity: 4) }

  subject { described_class.new(product_code: 'A', minimum_quantity: 4, price: 10) }

  describe '#apply' do
    context 'the quantity is below the minimum' do
      let(:basket) { [below_minimum, unrelated_product] }

      it 'does not apply discount' do
        expect(subject.apply(basket)).to eq(basket)
      end
    end

    context 'the quantity is exactly the minimum' do
      let(:basket) { [exact_quantity, unrelated_product] }

      it 'applies the discount' do
        discounted = exact_quantity.discounted_by(5)

        expect(subject.apply(basket)).to eq([discounted, unrelated_product])
      end
    end

    context 'the quantity is above the minimum' do
      let(:basket) { [above_minimum, unrelated_product] }

      it 'applies the discount' do
        discounted = above_minimum.discounted_by(5)

        expect(subject.apply(basket)).to eq([discounted, unrelated_product])
      end
    end
  end
end
