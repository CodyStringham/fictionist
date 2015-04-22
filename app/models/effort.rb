class Effort < ActiveRecord::Base

  has_many :user_efforts

  KINDS = [:share_location_information, :request_a_concert, :spotify_playlist, :blog_post, :upload_content, :facebook_like, :twitter_like, :instagram_like, :youtube_like, :facebook_post, :twitter_post, :instagram_post, :youtube_post]

  enum kind: KINDS

  VALIDATABLE = KINDS.delete_if {|x| x == :share_location_information || x == :request_a_concert || x == :upload_content }

  # VENUES = [:denver, :salt_lake_city, :orem, :reno, :boise, :portland, :las_vegas]

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
