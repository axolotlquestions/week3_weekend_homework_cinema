require_relative('models/customers')
require_relative('models/films')
require_relative('models/tickets')

require('pry-byebug')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()


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
customer4 = Customer.new({
  'name' => 'Dave',
  'funds' => 0
  })

customer1.save()
customer2.save()
customer3.save()
customer4.save()

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

ticket1 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })

ticket2 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film2.id
  })

ticket3 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film3.id
  })

ticket4 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id
  })

ticket5 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id
  })

ticket6 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film3.id
  })

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()

Ticket.buy(customer3, film1)
Ticket.buy(customer4, film1)

binding.pry
nil
