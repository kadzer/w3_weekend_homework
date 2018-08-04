require( 'pry-byebug' )
require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/ticket' )

customer1 = Customer.new({ 'name' => 'Boris Johnson', 'funds' => 50 })
customer1.save()
customer2 = Customer.new({ 'name' => 'Michael Gove', 'funds' => 25 })
customer2.save()

film1 = Film.new({ 'title' => 'How To Lose Friends And Alienate People', 'price' => '15'})
film1.save()
film2 = Film.new({ 'title' => 'On The Beach', 'price' => '10'})
film2.save()


ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id})
ticket3.save()

binding.pry
nil
