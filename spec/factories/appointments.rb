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

FactoryBot.define do
  factory :appointment do
    worker_bee { nil }
    date { "2020-08-22" }
    pollen_globs { "9.99" }
    nectar { 1 }
    advisement { 1 }
    adv_accepted { false }
  end
end
