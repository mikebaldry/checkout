class Checkout
  def initialize(rules)
    @rules = rules
    @products = []
  end

  def scan(product)
    @products << product
  end

  def total
    discounted_line_items
      .sum(&:sub_total)
      .round(2)
  end

  private

  def discounted_line_items
    @rules.reduce(line_items) do |line_items, rule|
      rule.apply(line_items)
    end
  end

  def line_items
    @products.
      group_by(&:itself).
      transform_values(&:count).
      map do |product, quantity|
        LineItem.new(product: product, quantity: quantity)
      end
  end
end