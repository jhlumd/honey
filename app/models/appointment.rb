# == Schema Information
#
# Table name: appointments
#
#  id            :bigint           not null, primary key
#  worker_bee_id :bigint           not null
#  date          :date             not null
#  pollen_globs  :decimal(3, 1)
#  nectar        :integer          not null
#  advisement    :integer
#  adv_accepted  :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Appointment < ApplicationRecord
  belongs_to :worker_bee

  validates :worker_bee, presence: { message: "must be linked" }
  validates :date, presence: true
  validates :pollen_globs, numericality: { greater_than_or_equal_to: 5,
    less_than_or_equal_to: 17.9, allow_nil: true }
  validates :nectar, presence: true, numericality: { only_integer: true }
  validates :advisement, numericality: { only_integer: true,
    greater_than_or_equal_to: 200, less_than_or_equal_to: 20000,
    allow_nil: true }
  validate :nectar_val, :advisement_increment

  private
    def nectar_val
      if nectar == 0 || nectar == nil
        return
      elsif nectar < 200 || nectar > 20000
        errors.add(:nectar, "must either be 0 or be between 200 and 20,000")
      elsif nectar % 100 != 0
        errors.add(:nectar, "must be in 100 increments")
      end
    end
    
    def advisement_increment
      unless advisement == nil || advisement % 100 == 0
        errors.add(:advisement, "must be in 100 increments")
      end
    end
end
