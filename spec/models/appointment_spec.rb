# == Schema Information
#
# Table name: appointments
#
#  id            :bigint           not null, primary key
#  worker_bee_id :bigint
#  date          :date             not null
#  pollen_globs  :decimal(3, 1)
#  nectar        :integer          not null
#  advisement    :integer
#  adv_accepted  :boolean          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Appointment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
