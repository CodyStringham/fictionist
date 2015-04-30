class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :display_notifications

  # before_action :set_controller, :if => :is_development

  private

  def display_notifications

    if user_signed_in?
      @notifications = []
      current_user.mailbox.inbox.each do |message|
        notification = message.receipts.where(mailbox_type: "inbox", is_read: false).first
        if notification
          @notifications << notification.message.body
        end
      end
      current_user.mailbox.inbox.destroy_all
    end

  end

  def is_development
    Rails.env.development?
  end

  def set_controller
    console
  end

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end



end
