class Redemption < ActiveRecord::Base
  belongs_to :user
  belongs_to :content
end

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
