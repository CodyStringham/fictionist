class Content < ActiveRecord::Base

  belongs_to :user

  enum view_permission: [:free, :points] #:vip_only, :vip_or_points, :paid

  validates :asset_type, :message, :published_at, :view_permission, :uploader_id, presence: true

  has_attached_file :asset,
                    styles: lambda { |a|
                      ["image/jpeg", "image/png", "image/jpg", "image/gif"].include?( a.content_type ) ? { thumb: "100x100#", small: "150x150>", medium: "300x300>", large: "500x500>" } : {}
                    }
  validates_attachment_content_type :asset, content_type: ["image/jpeg", "image/png", "image/jpg", "image/gif", "application/pdf", "audio/ogg", "applocation/ogg"]

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
