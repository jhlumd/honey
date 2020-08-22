class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.references :worker_bee, foreign_key: true
      t.date :date, null: false
      t.decimal :pollen_globs, precision: 3, scale: 1
      t.integer :nectar, null: false
      t.integer :advisement
      t.boolean :adv_accepted, null: false

      t.timestamps
    end

    add_index :appointments, :date
  end
end
