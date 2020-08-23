# == Schema Information
#
# Table name: combs
#
#  id         :bigint           not null, primary key
#  supervisor :string           not null
#  sweet_spot :decimal(3, 1)    not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comb < ApplicationRecord
  has_many :worker_bees, inverse_of: :comb
  
  validates :supervisor, presence: true
  validates :sweet_spot, presence: true,
    numericality: { greater_than_or_equal_to: 5.1, less_than_or_equal_to: 17.9 }
end
