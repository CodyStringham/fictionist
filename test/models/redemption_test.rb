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

require "test_helper"

class RedemptionTest < ActiveSupport::TestCase

  def redemption
    @redemption ||= Redemption.new
  end

  def test_valid
    assert redemption.valid?
  end

end
