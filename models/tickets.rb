require_relative('../db/sql_runner')
require_relative('./customers')
require_relative('./films')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(details)
    @id = details['id'].to_i()if details['id']
    @customer_id = details['customer_id'].to_i()
    @film_id = details['film_id'].to_i()

  end

#create

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id;"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run( sql, values ).first
    @id = ticket['id'].to_i()
  end

#read

  def self.all()
    sql = "SELECT * FROM tickets;"
    values = []
    tickets = SqlRunner.run(sql, values)
    result = tickets.map { |ticket| ticket.new(ticket) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM tickets WHERE id = $1;"
    values = [id]
    results = SqlRunner.run(sql, values)
    ticket = results.first[0]
    return Ticket.new(ticket)
  end

#update

  def update()
   sql = "
   UPDATE tickets SET (
     customer_id,
     film_id
   ) =
   (
     $1, $2
   )
   WHERE id = $3;"
   values = [@customer_id, @film_id, @id]
   SqlRunner.run(sql, values)
  end

#delete

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets where id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

#buying a ticket

  def self.buy(customer, film)
    #does customer have enough money
    return nil if customer.funds < film.price
    #create ticket
    ticket = Ticket.new ({
    'customer_id' => customer.id,
    'film_id' => film.id
    })
    ticket.save()
    #deduct money from customer
    customer.funds -= film.price
    customer.update
  end







end
