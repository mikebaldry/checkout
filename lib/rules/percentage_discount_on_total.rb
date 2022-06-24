module Rules
  class PercentageDiscountOnTotal
    def initialize(minimum_total:, discount_percentage:)
      @minimum_total = minimum_total
      @discount = discount_percentage / 100.0
    end

    def apply(basket)
      total = basket.sum(&:sub_total)
      return basket if total < @minimum_total

      basket.map do |product|
        product.discounted_by(product.price * @discount)
      end
    end
  end
end