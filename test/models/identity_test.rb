require "test_helper"

class IdentityTest < ActiveSupport::TestCase

  def identity
    @identity ||= Identity.new
  end

  def test_valid
    assert identity.valid?
  end

end
