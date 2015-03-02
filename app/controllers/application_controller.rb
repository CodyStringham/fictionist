class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :set_controller, :if => :is_development

  private

  def is_development
    Rails.env.development?
  end

  def set_controller
    console
  end

end
