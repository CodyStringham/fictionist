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
#  id                 :integer          not null, primary key
#  asset_type         :string           not null
#  message            :string           not null
#  location           :string
#  published_at       :datetime
#  view_permission    :integer
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  asset_file_name    :string
#  asset_content_type :string
#  asset_file_size    :integer
#  asset_updated_at   :datetime
#
