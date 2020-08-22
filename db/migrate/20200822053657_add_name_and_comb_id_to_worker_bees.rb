class AddNameAndCombIdToWorkerBees < ActiveRecord::Migration[5.1]
  def change
    add_column :worker_bees, :name, :string, null: false
    add_reference :worker_bees, :comb, foreign_key: true
  end
end
