class VisitorsController < ApplicationController
  def sign_in
    redirect_to welcome_path if user_signed_in?
  end

  def index
  end
end
