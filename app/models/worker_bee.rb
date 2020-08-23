# == Schema Information
#
# Table name: worker_bees
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string           not null
#  comb_id    :bigint           not null
#

class WorkerBee < ApplicationRecord
  default_scope { order(id: :asc) }

  belongs_to :comb

  has_many :appointments, -> { order(date: :desc) }, inverse_of: :worker_bee,
    dependent: :destroy
  
  validates :name, presence: true
  validates :comb, presence: { message: "affiliation required" }
end
