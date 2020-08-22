# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# --- Delete existing rows if any
Comb.destroy_all
WorkerBee.destroy_all
Appointment.destroy_all

# --- Settings
num_combs = 5   # Set number of Combs
ss_min = 10.0   # Set min p/g SweetSpot
ss_max = 15.0   # Set max p/g SweetSpot
pop_min = 5     # Set min number of Bees in a Comb
pop_max = 10    # Set max number of Bees in a Comb

# --- Create Combs
num_combs.times do
  supervisor = Faker::Name.first_name
  sweet_spot = rand(ss_min..ss_max).round(1)
  cur_comb = Comb.create(supervisor: supervisor, sweet_spot: sweet_spot)

  # --- Create WorkerBees
  population = rand(pop_min..pop_max)
  population.times do
    name = Faker::Name.first_name
    cur_bee = WorkerBee.create(name: name, comb_id: cur_comb.id)

    # --- Create Appointments (PollenGlob, Nectar, Advisement)
    # Do first appt manually
    date = Date.new(2020, 7, 15)
    active_adv = 600
    Appointment.create(worker_bee_id: cur_bee.id, date: date,
      pollen_glob: rand(5.0..17.9).round(1), nectar: active_adv,
      advisement: active_adv, adv_accepted: true)

    pg_days = [rand(2..3), rand(5..6), rand(7..8), rand(10..11), rand(13..14)]
    adv_days = [rand(4..8), rand(11..14)]
    for i in 1..14 do
      # Dates: To emulate 2-3 times a week, 20% of the time the next appt is
      # +2 days and +3 days 80%
      d_to_add = 2
      if rand() <= 0.8
        d_to_add += 1
      end
      date += d_to_add

      # PollenGlob measurement - about once weekly
      pollen_glob = nil
      if pg_days.include?(i) 
        pollen_glob = rand(5.0..17.9).round(1)
      end

      # Advisement - given every couple of weeks means 20% of the time
      new_adv = nil
      if adv_days.include?(i) 
        new_adv = rand(2..200) * 100
      end
      active_adv = new_adv.nil? ? active_adv : new_adv
      
      # Nectar allowance is skipped 5-10% of the time.
      nectar = active_adv
      if rand() <= 0.075
        nectar = 0
      end

      Appointment.create(worker_bee_id: cur_bee.id, date: date,
        pollen_glob: pollen_glob, nectar: nectar, advisement: new_adv,
        adv_accepted: nectar == active_adv)
    end
  end
end
