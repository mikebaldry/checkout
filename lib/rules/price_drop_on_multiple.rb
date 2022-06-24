module Rules
  class PriceDropOnMultiple
    def initialize(product_code:, minimum_quantity:, price:)
      @product_code = product_code
      @minimum_quantity = minimum_quantity
      @price = price
    end

    def apply(line_items)
      line_items.map do |product|
        next product if product.code != @product_code || product.quantity < @minimum_quantity

        product.discounted_by(product.price - @price)
      end
    end
  end
end