def client_code(order)
  puts "PRECIO: #{order.price}"
  puts "DESCRIPCION: #{order.description}"
end

def client_code2(order1, order2)
  order1.add(order2) if order1.box?

  print "Descripcion: #{order1.description}"
  print "Precio: #{order1.price}"
end

single_product = Product.new(100, 'cooler base')
puts 'Client: I\'ve got a simple component:'
client_code(single_product)
puts "\n"

complete_order = Box.new

order1 = Box.new
order1.add(Product.new(200, 'headphones'))
order1.add(Product.new(300, 'chair'))

order2 = Box.new
order2.add(Product.new(400, 'monitor'))

complete_order.add(order1)
complete_order.add(order2)

puts 'Client: Now I\'ve got a composite tree:'
client_code(complete_order)
puts "\n"

puts 'Client: I don\'t need to check the components classes even when managing the tree:'
client_code2(complete_order, single_product)
