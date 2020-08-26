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
num_combs = 12  # Set number of Combs
pop_min = 9     # Set min number of Bees in a Comb
pop_max = 15    # Set max number of Bees in a Comb

# --- Create Combs
num_combs.times do
  supervisor = Faker::Name.first_name
  sweet_spot = rand(10.0..15.0).round(1)
  cur_comb = Comb.create(supervisor: supervisor, sweet_spot: sweet_spot)

  # --- Create WorkerBees
  population = rand(pop_min..pop_max)
  population.times do
    name = Faker::Name.first_name
    cur_bee = WorkerBee.create(name: name, comb_id: cur_comb.id)

    # --- Create Appointments (PollenGlob, Nectar, Advisement)
    # Do first appt manually
    date = Date.new(2020, 7, 15)
    active_adv = rand(6..90) * 100
    Appointment.create(worker_bee_id: cur_bee.id, date: date,
      pollen_globs: rand(5.0..17.9).round(1), nectar: active_adv,
      advisement: active_adv, adv_accepted: true)

    pg_days = [rand(2..3), 5, rand(7..8), rand(10..11), rand(13..14)]
    adv_days = [rand(4..8), rand(11..14)]
    for i in 1..14 do
      # Dates: To emulate 2-3 times a week, 20% of the time the next appt is
      # +2 days and +3 days 80%
      d_to_add = (rand() <= 0.8) ? 3 : 2
      date += d_to_add

      # PollenGlob measurement - about once weekly
      pollen_globs = pg_days.include?(i) ? (rand(5.0..17.9).round(1)) : nil

      # Advisement - given every couple of weeks
      new_adv = adv_days.include?(i) ? (rand(2..200) * 100) : nil
      # Update active_adv if there is a new_adv
      unless new_adv.nil?
        active_adv = new_adv
      end
      
      # Nectar allowance is 0 (skipped) 7.5% of the time, same as the active
      # adv 72.5% of the time, and random 20% of the time.
      nectarRand = rand()
      if nectarRand <= 0.075
        nectar = 0
      elsif nectarRand <= 0.8
        nectar = active_adv
      else
        nectar = rand(2..200) * 100
      end

      # Advisements are accepted by default
      # adv_accepted is nil when there is no new advisement
      adv_accepted = nil
      unless new_adv.nil?
        if new_adv == nectar
          adv_accepted = true;
        else
          adv_accepted = false;
        end
      end

      Appointment.create(worker_bee_id: cur_bee.id, date: date,
        pollen_globs: pollen_globs, nectar: nectar, advisement: new_adv,
        adv_accepted: adv_accepted)
    end
  end
end
