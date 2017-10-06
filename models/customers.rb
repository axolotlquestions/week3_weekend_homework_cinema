require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize (details)
    @id = details['id'].to_i
    @name = details['name']
    @funds = details['funds'].to_i
  end

#create
  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id;"
    values = [@name, @funds]
    customer = SqlRunner.run( sql, values ).first
    @id = customer['id'].to_i
  end

#read

  def self.all()
    sql = "SELECT * FROM customers;"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [id]
    results = SqlRunner.run(sql, values)
    customer = results.first[0]
    return Customer.new(customer)
  end

#update

  def update()
   sql = "
   UPDATE customers SET (
     name,
     funds
   ) =
   (
     $1, $2
   )
   WHERE id = $3;"
   values = [@name, @funds, @id]
   SqlRunner.run(sql, values)
 end

#delete

 def self.delete_all()
   sql = "DELETE FROM customers;"
   values = []
   SqlRunner.run(sql, values)
 end

 def delete()
   sql = "DELETE FROM customers where id = $1;"
   values = [@id]
   SqlRunner.run(sql, values)
 end

 def films()
   sql = "SELECT films.* FROM films
        INNER JOIN tickets
        ON tickets.film_id = films.id
        WHERE customer_id = $1;"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map { |film| Film.new(film) }
  end

  def ticket_count
    sql = "SELECT COUNT(id) from tickets
          where customer_id = $1;"
    values =[@id]
    result = SqlRunner.run(sql, values)
    return "#{@name} has #{result.first['count']} tickets"
  end


end
