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

  validate :is_effort_repeatable?, on: :create
  validate :its_been_a_week?, on: :create

  after_validation :get_value

  def approve
    self.user.update_attributes(points: user.points + value)
    self.update_attributes(status: 'approved', completed_at: DateTime.now.utc)
    get_admin.send_message(user, "Congrats, your #{Effort.find(effort_id).name} has been approved!", "Point Request")
  end

  def decline
    self.update_attributes(status: 'declined')
    get_admin.send_message(user, "Sorry, your #{Effort.find(effort_id).name} has been declined.", "Point Request")
  end

  private

  def get_admin
    User.find_by(role: 2)
  end

  def is_effort_repeatable?
    if User.find(user.id).user_efforts.any? {|x| x.effort == self.effort }
      unless self.effort.repeatable
        errors.add(:effort, "cannot be repeated.")
      end
    end
  end

  def its_been_a_week?
    return unless errors.blank?
    last_effort = User.find(user.id).user_efforts.where(effort_id: effort.id).order(completed_at: :desc).first
    if last_effort
      if last_effort.completed_at
        unless last_effort.completed_at <= Time.now.utc - 7.days
          resets_at = last_effort.completed_at + 7.days
          errors.add(:effort, "cannot be resubmitted until #{resets_at.strftime("%B %-d, %Y - %-l:%M %p")}")
        end
      else
        errors.add(:effort, "is already pending approval.")
      end
    end
  end

  def get_value
    self.value = Effort.find(effort_id).value
  end

end

# == Schema Information
#
# Table name: user_efforts
#
#  id                      :integer          not null, primary key
#  status                  :integer          default(0)
#  value                   :integer
#  screenshot_file_name    :string
#  screenshot_content_type :string
#  screenshot_file_size    :integer
#  screenshot_updated_at   :datetime
#  user_id                 :integer
#  effort_id               :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  completed_at            :datetime
#
