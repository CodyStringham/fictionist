require "test_helper"

class ContentTest < ActiveSupport::TestCase

  def content
    @content ||= Content.new
  end

  def test_valid
    assert content.valid?
  end

end
