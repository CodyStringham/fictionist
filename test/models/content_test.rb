require "test_helper"

class ContentTest < ActiveSupport::TestCase

  def content
    @content ||= Content.new
  end

  def test_valid
    assert content.valid?
  end

end

# == Schema Information
#
# Table name: contents
#
#  id              :integer          not null, primary key
#  content_type    :string
#  message         :string
#  location        :string
#  published_at    :datetime
#  view_permission :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
