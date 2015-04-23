class Effort < ActiveRecord::Base

  has_many :user_efforts

  KINDS = [:spotify_playlist, :blog_post, :facebook_like, :twitter_like, :instagram_like, :youtube_like, :facebook_post, :twitter_post, :instagram_post, :youtube_post]

  SPEICALS = [:share_location_information, :request_a_concert, :upload_content]

  enum kind: KINDS + SPEICALS

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
