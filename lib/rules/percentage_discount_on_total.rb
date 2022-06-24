module Rules
  class PercentageDiscountOnTotal
    def initialize(minimum_total:, discount_percentage:)
      @minimum_total = minimum_total
      @discount = discount_percentage / 100.0
    end

    def apply(line_items)
      total = line_items.sum(&:sub_total)
      return line_items if total < @minimum_total

      line_items.map do |product|
        product.discounted_by(product.price * @discount)
      end
    end
  end
end