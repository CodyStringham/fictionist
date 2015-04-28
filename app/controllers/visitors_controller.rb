class VisitorsController < ApplicationController
  before_action :display_notifications

  def sign_in
    redirect_to welcome_path if user_signed_in?
  end

  def index
  end

  def grid
  end

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
end
