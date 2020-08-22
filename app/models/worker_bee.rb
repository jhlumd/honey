# == Schema Information
#
# Table name: worker_bees
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string           not null
#  comb_id    :bigint
#

class WorkerBee < ApplicationRecord
  validates :name, presence: true
  belongs_to :comb
  validates :comb, presence: { message: "must be assigned" }
  has_many :appointments, inverse_of: :worker_bee
end
