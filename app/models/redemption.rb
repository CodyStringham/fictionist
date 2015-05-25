class Redemption < ActiveRecord::Base
  belongs_to :user
  belongs_to :content

  validates :user_id, :content_id, :value, presence: true
  validate :has_enough_points?, on: :create

  after_create :burn_points

  def has_enough_points?
    unless User.find(user_id).points >= value
      errors.add(:redemption, "You don't have enough points.")
    end
  end

  def burn_points
    user = User.find user_id
    user.update_attributes(points: user.points -= value)
  end

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
