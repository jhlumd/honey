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

require 'rails_helper'

RSpec.describe WorkerBee, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
