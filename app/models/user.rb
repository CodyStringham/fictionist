class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  LOCATIONS = [:salt_lake_city, :orem, :provo, :ogden]

  enum role: [:user, :band_member, :admin]
  enum preferred_location: LOCATIONS

  has_one :identity, dependent: :destroy
  has_many :uploaded_contents, class_name: "Content", primary_key: "id", foreign_key: "uploader_id"

  has_many :user_efforts, dependent: :destroy

  has_many :redemptions, dependent: :destroy
  has_many :purchased_contents, through: :redemptions, class_name: "Content", source: :content

  scope :fans, -> { where(role: 0) }
  scope :band_members, -> { where(role: 1) }
  scope :admins, -> { where(role: 2) }

  scope :confirmed, -> { where.not(confirmed_at: nil) }

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates :points, numericality: { greater_than_or_equal_to: 0 }
  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update

  acts_as_messageable
  # u = User.find_by(role: 2) (admin user)
  # u.send_message(u, "Hello, someone wants you to approve their points", "User Request")

  # u = User.find_by(submitted_request: them)
  # a = User.find_by(role: 2) (admin user)
  # a.send_message(u, "Congrats! You have been awarded points for doing good things.", "FictMonies Awarded")
  # a.send_message(u, "Sorry, your point request has been declined.", "FictMonies Declined")

  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(email: email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  # devise confirm! method overriden
  def confirm!
    reward_inviter
    super
  end

  # devise_invitable accept_invitation! method overriden
  def accept_invitation!
    self.confirm!
    super
  end

  # devise_invitable invite! method overriden
  def invite!
    super
    self.update_attributes(confirmed_at: nil)
  end

  def mailboxer_name
    return "You should add method :mailboxer_name in your Messageable model"
  end

  def mailboxer_email(object)
    self.subscribed == true ? (return self.email) : (return nil)
  end

  private

  def reward_inviter
    if self.invited_by_id
      begin
        inviter = User.find self.invited_by_id
        inviter.update_attributes(points: inviter.points + 50)
      rescue ActiveRecord::RecordNotFound
        logger.debug "inviter not found"
      end
    end
  end

end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  role                   :integer          default(0)
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#  points                 :integer          default(0)
#  preferred_location     :integer
#  subscribed             :boolean          default(TRUE)
#  requested_venue        :string
#
