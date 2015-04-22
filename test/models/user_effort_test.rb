# == Schema Information
#
# Table name: user_efforts
#
#  id                      :integer          not null, primary key
#  status                  :integer          default("0")
#  value                   :integer
#  screenshot_file_name    :string
#  screenshot_content_type :string
#  screenshot_file_size    :integer
#  screenshot_updated_at   :datetime
#  user_id                 :integer
#  effort_id               :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require "test_helper"

class UserEffortTest < ActiveSupport::TestCase

  def user_effort
    @user_effort ||= UserEffort.new
  end

  def test_valid
    assert user_effort.valid?
  end

end
