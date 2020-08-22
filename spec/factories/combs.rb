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

FactoryBot.define do
  factory :comb do
    supervisor { "MyString" }
    sweet_spot { "9.99" }
  end
end
