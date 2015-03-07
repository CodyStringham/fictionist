require "test_helper"

class IdentityTest < ActiveSupport::TestCase

  def identity
    @identity ||= Identity.new
  end

  def test_valid
    assert identity.valid?
  end

end

# == Schema Information
#
# Table name: identities
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
