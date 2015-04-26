class UserEffort < ActiveRecord::Base
  belongs_to :user
  belongs_to :effort

  enum status: [:pending, :approved, :declined]

  scope :pending, -> { where(status: 0) }
  scope :approved, -> { where(status: 1) }
  scope :declined, -> { where(status: 2) }

  has_attached_file :screenshot, styles: { thumb: "100x100", large: "1000x1000>" }

  validates_attachment_content_type :screenshot, content_type: ["image/jpg", "image/jpeg", "image/png"]
  validates :user_id, :effort_id, :screenshot, presence: true
  validate :is_effort_repeatable?

  # after_validation :completed_recently?
  after_validation :get_value

  # u = User.find_by(role: 2) (admin user)
  # u.send_message(u, "Hello, someone wants you to approve their points", "User Request")

  # u = User.find_by(submitted_request: them)
  # a = User.find_by(role: 2) (admin user)
  # a.send_message(u, "Congrats! You have been awarded points for doing good things.", "FictMonies Awarded")
  # a.send_message(u, "Sorry, your point request has been declined.", "FictMonies Declined")

  def approve
    user.update_attributes(points: user.points + value)
    update_attributes(status: 'approved')
    get_admin.send_message(user, "Congrats, your points have been approved!", "Point Request")
  end

  def decline
    update_attributes(status: 'declined')
    get_admin.send_message(user, "Sorry, your points have been declined.", "Point Request")
  end

  private

  def get_admin
    User.find_by(role: 2)
  end

  def is_effort_repeatable?
    u = User.find user
    if u.user_efforts.any? {|x| x.effort == self.effort }
      unless effort.repeatable
        errors.add(:effort, "cannot be repeated.")
      end
    end
  end

  # def completed_recently?
  #   unless effort.repeatable?
  #     errors.add(:completed_recently, "You haven't waited a week, try again later.")
  #   end
  # end

  def get_value
    self.value = Effort.find(effort_id).value
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
