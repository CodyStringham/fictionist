class Effort < ActiveRecord::Base
  belongs_to :user
  enum :kind [:location, :request, :playlist, :blog, :content,
              :like_fb, :like_tw, :like_ig, :like_yt,
              :post_fb, :post_tw, :post_ig, :post_yt]

end

# == Effort Kinds
# :location => shares location information
# :request => requests a concert location
# :playlist => makes a spotify playlist
# :blog => writes a post
# :content => uploads a photo / song?
# :like_fb => facebook
# :like_tw => twitter
# :like_ig => instagram
# :like_yt => youtube
# :post_fb => facebook
# :post_tw => twitter
# :post_ig => instagram
# :post_yt => youtube


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
