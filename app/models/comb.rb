# == Schema Information
#
# Table name: combs
#
#  id         :bigint           not null, primary key
#  supervisor :string           not null
#  sweet_spot :decimal(, )      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comb < ApplicationRecord
  valid_ss = []
  for i in 100..150 do
    valid_ss << (i / 10.0)
  end

  validates :supervisor, :sweet_spot, presence: true
  validates :sweet_spot, inclusion: { in: valid_ss,
    message: "must be between 10.0 and 15.0 (only 0.1 increment)" }
  has_many :worker_bees, inverse_of: :comb
end
