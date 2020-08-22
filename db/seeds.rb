# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Combs and Bees
Comb.destroy_all
WorkerBee.destroy_all

num_combs = 5   # Set number of Combs
ss_min = 10.0   # Set min p/g SweetSpot
ss_max = 15.0   # Set max p/g SweetSpot
pop_min = 10    # Set min number of Bees in a Comb
pop_max = 20    # Set max number of Bees in a Comb

num_combs.times do
  supervisor = Faker::Name.first_name
  sweet_spot = rand(ss_min..ss_max).round(1)
  comb1 = Comb.create(supervisor: supervisor, sweet_spot: sweet_spot)

  population = rand(pop_min..pop_max)

  population.times do
    name = Faker::Name.first_name
    WorkerBee.create(name: name, comb_id: comb1.id)
  end
end
