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

require "test_helper"

class EffortTest < ActiveSupport::TestCase

  def effort
    @effort ||= Effort.new
  end

  def test_valid
    assert effort.valid?
  end

end
