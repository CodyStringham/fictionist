class Content < ActiveRecord::Base

  belongs_to :user
  enum view_permission: [:free, :points] #:vip_only, :vip_or_points, :paid 

  validates :content_type, :message, :published_at, :view_permission, :user_id, presence: true

  has_attached_file :item, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :item, :content_type => /\Aimage\/.*\Z/

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
