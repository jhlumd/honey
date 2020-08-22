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
#  adv_accepted  :boolean          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Appointment < ApplicationRecord
  belongs_to :worker_bee

  validates :worker_bee, presence: { message: "must be linked" }
end
