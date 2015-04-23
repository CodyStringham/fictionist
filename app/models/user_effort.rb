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

  # u = User.find_by(role: 2) (admin user)
  # u.send_message(u, "Hello, someone wants you to approve their points", "User Request")

  # u = User.find_by(submitted_request: them)
  # a = User.find_by(role: 2) (admin user)
  # a.send_message(u, "Congrats! You have been awarded points for doing good things.", "FictMonies Awarded")
  # a.send_message(u, "Sorry, your point request has been declined.", "FictMonies Declined")

  def approve
    self.user.update_attributes(points: self.user.points + self.value)
    self.update_attributes(status: 'approved')
    get_admin.send_message(self.user, "Congrats, your points have been approved!", "Point Request")
  end

  def decline
    self.update_attributes(status: 'declined')
    get_admin.send_message(self.user, "Sorry, your points have been declined.", "Point Request")
  end

  private

  def get_admin
    User.find_by(role: 2)
  end

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
