require_relative("../db/sql_runner")

class Ticket
  attr_reader :id, :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end


  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2)
    RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end


  def delete()
      sql = "DELETE FROM tickets WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end


  def film()
    sql = "SELECT films.* FROM films WHERE id = $1"
    values = [@film_id]
    film = SqlRunner.run(sql, values)[0]
    return film
  end


  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    customer = SqlRunner.run(sql, values).first
    return customer
  end


  def self.all()
    sql = "SELECT * from tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    result = tickets.map {|ticket| Ticket.new(ticket)}
    return result
  end


end
