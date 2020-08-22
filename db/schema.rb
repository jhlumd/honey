# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200822111015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "worker_bee_id"
    t.date "date", null: false
    t.decimal "pollen_globs", precision: 3, scale: 1
    t.integer "nectar", null: false
    t.integer "advisement"
    t.boolean "adv_accepted", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_appointments_on_date"
    t.index ["worker_bee_id"], name: "index_appointments_on_worker_bee_id"
  end

  create_table "combs", force: :cascade do |t|
    t.string "supervisor", null: false
    t.decimal "sweet_spot", precision: 3, scale: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "worker_bees", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.bigint "comb_id"
    t.index ["comb_id"], name: "index_worker_bees_on_comb_id"
  end

  add_foreign_key "appointments", "worker_bees"
  add_foreign_key "worker_bees", "combs"
end
