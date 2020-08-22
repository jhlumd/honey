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

require 'rails_helper'

RSpec.describe Comb, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
