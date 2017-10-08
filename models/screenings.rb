require_relative('../db/sql_runner')
require_relative('./films')

class Screening

  attr_reader :id
  attr_accessor :time, :filmid

  def initialize(details)
    @id = details['id'].to_i()
    @time = details['time']
    @filmid = details['filmid'].to_i()
  end

#create

  def save()
    sql = "INSERT INTO screenings
    (
      time,
      filmid
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id;"
    values = [@time, @filmid]
    screening = SqlRunner.run( sql, values ).first
    @id = screening['id'].to_i()
  end

#read

  def self.all()
    sql = "SELECT * FROM screenings;"
    values = []
    screenings = SqlRunner.run(sql, values)
    result = screenings.map { |screening| screening.new(screening) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM screenings WHERE id = $1;"
    values = [id]
    results = SqlRunner.run(sql, values)
    screening = results.first[0]
    return screening.new(screening)
  end

#update

  def update()
   sql = "
   UPDATE screenings SET (
     time,
     filmid
   ) =
   (
     $1, $2
   )
   WHERE id = $3;"
   values = [@time, @filmid, @id]
   SqlRunner.run(sql, values)
  end

#delete

  def self.delete_all()
    sql = "DELETE FROM screenings;"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings where id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end
end
