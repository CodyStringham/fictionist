# == Schema Information
#
# Table name: redemptions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  value      :integer
#

FactoryGirl.define do
  factory :redemption do
    user nil
content nil
  end

end
