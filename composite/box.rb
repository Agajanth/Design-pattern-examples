require './Order'

class Box < Order
  def initialize
    super
    @children = []
  end

  def add(component)
    @children.append(component)
    component.parent = self
  end

  def remove(component)
    @children.remove(component)
    component.parent = nil
  end

  def box?
    true
  end

  def price
    total_price = 0
    @children.each { |child| total_price += child.price }
    total_price
  end

  def description
    results = []
    @children.each { |child| results.append(child.description) }
    puts "descripcion pedido(#{results.join("\n")})"
  end
end
