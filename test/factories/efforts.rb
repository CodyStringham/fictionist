# == Schema Information
#
# Table name: efforts
#
#  id           :integer          not null, primary key
#  name         :string
#  kind         :integer
#  value        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  repeatable   :boolean
#  completed_on :datetime
#

FactoryGirl.define do
  factory :effort do
    type 1
status 1
user nil
value 1
  end

end
