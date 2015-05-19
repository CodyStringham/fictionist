class Content < ActiveRecord::Base
  belongs_to :user
  has_many :redemptions
  has_many :users, through: :redemptions

  enum view_permission: [:free, :points] #:vip_only, :vip_or_points, :paid
  enum asset_type: [:photo, :music, :video, :pdf, :text]

  validates :asset_type, :message, :uploader_id, presence: true
  # validates_inclusion_of :view_permission, in: ['free', 'points']

  has_attached_file :asset,
                    styles: lambda { |a|
                      ["image/jpeg", "image/png", "image/jpg", "image/gif"].include?( a.content_type ) ? { thumb: "100x100", thumb_feature: "100x200", small: "150x150>", medium: "300x300>", large: "500x500>" } : {}
                    }
  validates_attachment_content_type :asset, content_type: ["image/jpeg", "image/png", "image/jpg", "image/gif", "application/pdf", "audio/ogg", "applocation/ogg", "audio/mpeg", "audio/mp3"]

end

# == Schema Information
#
# Table name: contents
#
#  id                 :integer          not null, primary key
#  message            :string           not null
#  location           :string
#  published_at       :datetime
#  view_permission    :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  asset_file_name    :string
#  asset_content_type :string
#  asset_file_size    :integer
#  asset_updated_at   :datetime
#  uploader_id        :integer
#  value              :integer          default("0")
#  asset_type         :integer          default("0")
#
