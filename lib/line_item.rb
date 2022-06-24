class LineItem
  include Comparable

  attr_reader :quantity

  def initialize(product:, quantity:, discount: 0)
    @product = product
    @quantity = quantity
    @discount = discount
  end

  def code
    @product.code
  end

  def price
    @product.price + @discount
  end

  def sub_total
    price * quantity
  end

  def discounted_by(amount)
    LineItem.new(
      product: @product,
      quantity: @quantity,
      discount: @discount - amount
    )
  end

  def <=>(other)
    comparable_data <=> other.comparable_data
  end

  protected

  def comparable_data
    [@product, @quantity, @discount]
  end
end