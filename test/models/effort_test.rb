# == Schema Information
#
# Table name: efforts
#
#  id                 :integer          not null, primary key
#  type               :integer
#  value              :integer
#  status             :integer
#  proof_file_name    :string
#  proof_content_type :string
#  proof_file_size    :integer
#  proof_updated_at   :datetime
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
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
