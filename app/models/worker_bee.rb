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

  before_validation :verify_different_comb, on: :update

  private
    def verify_different_comb
      if comb_id == params[:comb_id].to_i
      
      end
    end
end
