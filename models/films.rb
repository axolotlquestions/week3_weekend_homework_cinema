require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize (details)
    @id = details['id'].to_i if details['id']
    @title = details['title']
    @price = details['price'].to_i
  end

#create
  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id;"
    values = [@title, @price]
    film = SqlRunner.run( sql, values ).first
    @id = film['id'].to_i
  end

#read

  def self.all()
    sql = "SELECT * FROM films;"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new(film) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM films WHERE id = $1;"
    values = [id]
    results = SqlRunner.run(sql, values)
    film = results.first[0]
    return Film.new(film)
  end

#update

  def update()
   sql = "
   UPDATE films SET (
     title,
     price
   ) =
   (
     $1, $2
   )
   WHERE id = $3;"
   values = [@title, @price, @id]
   SqlRunner.run(sql, values)
  end

#delete

 def self.delete_all()
   sql = "DELETE FROM films;"
   values = []
   SqlRunner.run(sql, values)
 end

 def delete()
   sql = "DELETE FROM films where id = $1;"
   values = [@id]
   SqlRunner.run(sql, values)
 end

 def customers()
    sql = "SELECT customers.* FROM customers
          INNER JOIN tickets
          ON tickets.customer_id = customers.id
          WHERE film_id = $1;"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map { |customer| Customer.new(customer) }
  end

  def screenings()
   sql = "SELECT screenings.* FROM screenings
         WHERE filmid = $1;"
   values = [@id]
   screenings = SqlRunner.run(sql, values)
   return screenings.map { |screening| Screening.new(screening) }
 end

  def attendance()
    sql = "SELECT COUNT(id) from tickets
          where film_id = $1;"
    values =[@id]
    result = SqlRunner.run(sql, values)
    return "#{result.first['count']} people are seeing #{@title}"
  end


end
