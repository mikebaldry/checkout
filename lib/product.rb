class Product
  attr_reader :code, :price

  def initialize(code:, price:, name: nil)
    @code = code
    @price = price
  end
end