class Content < ActiveRecord::Base
  belongs_to :user
  has_many :redemptions
  has_many :users, through: :redemptions

  enum view_permission: [:free, :points] #:vip_only, :vip_or_points, :paid
  enum asset_type: [:image, :music, :video, :pdf, :text]

  # validates :view_permission, :value, :uploader_id, :message, :asset_type, presence: true
  # validates :asset_type, :message, :uploader_id, presence: true
  # validates_inclusion_of :view_permission, in: ['free', 'points']


  # Global Validations
  validates :view_permission, :value, :message, :asset_type, :thumbnail, presence: true
  validates_inclusion_of :asset_type, in: ['image', 'music', 'video']

  # Image Validations

  # Music Validations

  # Video Validations
  validates :embed_link, presence: true, if: :content_is_video?


  has_attached_file :asset,
                    styles: lambda { |a|
                      ["image/jpeg", "image/png", "image/jpg", "image/gif"].include?( a.content_type ) ? { thumb: "100x100", thumb_feature: "100x200", small: "150x150>", medium: "300x300>", large: "500x500>" } : {}
                    }
  validates_attachment_content_type :asset, content_type: ["image/jpeg", "image/png", "image/jpg", "image/gif", "application/pdf", "audio/ogg", "applocation/ogg", "audio/mpeg", "audio/mp3", "audio/mp4"]

  has_attached_file :thumbnail,
                    styles: { thumb: "200x200" }
  validates_attachment_content_type :thumbnail, content_type: ["image/jpeg", "image/png", "image/jpg", "image/gif"]

  def download_url
    path_name = self.asset.path
    path_name[0] = ""
    S3.objects[ path_name ].url_for( :read,
      expires_in: 60.minutes,
      use_ssl:    false,
      response_content_disposition: "attachment; filename='#{self.asset_file_name}'" ).to_s
  end

  def content_is_video?
    asset_type == "video"
  end

  def content_is_music?
    asset_type == "music"
  end

  def content_is_image?
    asset_type == "image"
  end

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
#  value              :integer
#  asset_type         :integer          default(0)
#  embed_link         :string
#
