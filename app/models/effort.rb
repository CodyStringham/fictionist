class Effort < ActiveRecord::Base
  belongs_to :user

  KINDS = [:share_location_information, :request_a_concert, :spotify_playlist, :blog_post, :upload_content, :facebook_like, :twitter_like, :instagram_like, :youtube_like, :facebook_post, :twitter_post, :instagram_post, :youtube_post]

  enum kind: KINDS

end

# == Schema Information
#
# Table name: efforts
#
#  id         :integer          not null, primary key
#  name       :string
#  kind       :integer
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
