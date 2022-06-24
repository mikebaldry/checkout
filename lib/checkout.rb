class Checkout
  def initialize(rules)
    @rules = rules
    @products = []
  end

  def scan(product)
    @products << product
  end

  def total
    discounted_basket
      .sum(&:sub_total)
      .round(2)
  end

  private

  def discounted_basket
    @rules.reduce(basket) do |basket, rule|
      rule.apply(basket)
    end
  end

  def basket
    @products.
      group_by(&:itself).
      transform_values(&:count).
      map do |product, quantity|
        BasketProduct.new(product: product, quantity: quantity)
      end
  end
end