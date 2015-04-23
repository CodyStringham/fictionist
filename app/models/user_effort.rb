class UserEffort < ActiveRecord::Base
  belongs_to :user
  belongs_to :effort

  enum status: [:pending, :approved, :declined]

  scope :pending, -> { where(status: 0) }
  scope :approved, -> { where(status: 1) }
  scope :declined, -> { where(status: 2) }

  after_validation :get_value

  has_attached_file :screenshot, styles: { thumb: "100x100", large: "1000x1000>" }

  validates_attachment_content_type :screenshot, content_type: ["image/jpg", "image/jpeg", "image/png"]
  validates :user_id, :effort_id, :screenshot, presence: true

  def approve
    self.user.update_attributes(points: self.user.points + self.value)
    self.update_attributes(status: 'approved')
  end

  def decline
    self.update_attributes(status: 'declined')
  end

  private

  def get_value
    self.value = Effort.find(self.effort_id).value
  end

end

# == Schema Information
#
# Table name: user_efforts
#
#  id                      :integer          not null, primary key
#  status                  :integer          default("0")
#  value                   :integer
#  screenshot_file_name    :string
#  screenshot_content_type :string
#  screenshot_file_size    :integer
#  screenshot_updated_at   :datetime
#  user_id                 :integer
#  effort_id               :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
