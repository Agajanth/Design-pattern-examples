class Order
  def parent
    @parent
  end

  def parent=(parent)
    @parent = parent
  end

  def add(component)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def remove(component)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def box?
    false
  end

  def price
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def description
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
