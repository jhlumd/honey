class CreateCombs < ActiveRecord::Migration[5.1]
  def change
    create_table :combs do |t|
      t.string :supervisor, null: false
      t.decimal :sweet_spot, precision: 3, scale: 1, null: false

      t.timestamps
    end
  end
end
