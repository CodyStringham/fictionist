class Effort < ActiveRecord::Base

  has_many :user_efforts

  ONETIME = [:facebook_like, :twitter_like, :instagram_like, :youtube_like]

  REPEATABLE = [:spotify_playlist, :blog_post, :facebook_post, :twitter_post, :instagram_post, :youtube_post]

  SPECIALS = [:share_location, :request_venue, :upload_content]

  KINDS = ONETIME + REPEATABLE + SPECIALS

  enum kind: KINDS

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
#  repeatable :boolean
#
