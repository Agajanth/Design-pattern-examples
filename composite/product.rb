require './Order'

class Product < Order
  attr_accessor :price, :description

  def initialize(price = 0, description = '')
    @price = price
    @description = description
  end
end
