class Users::RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit( :name, :email, :subscribed, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit( :name, :email, :subscribed, :password, :password_confirmation, :current_password, :preferred_location )
    end
  end

end
