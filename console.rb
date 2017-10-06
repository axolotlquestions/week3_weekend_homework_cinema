require_relative('models/customers')
require_relative('models/films')

require('pry-byebug')

Customer.delete_all()
Film.delete_all()


customer1 = Customer.new({
  'name' => 'Alice',
  'funds' => 50
  })
customer2 = Customer.new({
  'name' => 'Bob',
  'funds' => 30
  })
customer3 = Customer.new({
  'name' => 'Carol',
  'funds' => 40
  })

customer1.save()
customer2.save()
customer3.save()

film1 = Film.new({
  'title' => 'Age of Ultron',
  'price' => 10
  })
film2 = Film.new({
  'title' => 'Bladerunner',
  'price' => 10
  })
film3 = Film.new({
  'title' => 'Colossus: The Forbin Project',
  'price' => 10
  })

film1.save()
film2.save()
film3.save()


binding.pry
nil
