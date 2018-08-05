require_relative("../db/sql_runner")
require_relative("ticket")

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end


  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end


  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end


  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets ON films.id = tickets.film_id
    WHERE tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new(film) }
    return result
  end


  def buy_ticket(film)
    sql = "UPDATE customers SET funds = $1 WHERE id = $2"
    funds = @funds - film.price.to_i
    values = [funds, @id]
    ticket = Ticket.new('customer_id' => @id, 'film_id' => film.id)
    ticket.save()
    SqlRunner.run(sql, values)
  end


  def self.all()
    sql = "SELECT * from customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map {|customer| Customer.new(customer)}
    return result
  end


end
