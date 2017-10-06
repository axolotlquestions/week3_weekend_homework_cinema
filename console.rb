require_relative('models/customers')

require('pry-byebug')

Customer.delete_all()


customer1 = Customer.new({
  'name' => 'Alice',
  'funds' => 50
  })
customer2 = Customer.new({
  'name' => 'Bob',
  'funds' => '30'
  })
customer3 = Customer.new({
  'name' => 'Carol',
  'funds' => 40
  })

customer1.save()
customer2.save()
customer3.save()

binding.pry
nil
