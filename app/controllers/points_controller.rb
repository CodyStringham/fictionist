class PointsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pending = current_user.user_efforts.pending
    @new_user = User.new
  end

  def new
    @effort = Effort.find(params[:effort_id])
    @request = current_user.user_efforts.new
  end

  def create
    @request = current_user.user_efforts.new(request_params)
    if @request.save
      redirect_to root_path, notice: 'Points were requested.'
    else
      redirect_to new_point_path(params[:effort_id]), alert: "#{@request.errors.full_messages.pop}"
    end
  end

  def share_location
  end

  def create_share_location
    if current_user.preferred_location.nil?
      points_awarded = true
      current_user.update_attributes(points: current_user.points + Effort.find_by(name: "Share Location").value)
    end
    if current_user.update_attributes(location_params)
      msg = points_awarded ? "You recieved points for sharing!" : "You already recieved points for sharing."
      redirect_to points_path, notice: "Your preferred location was successfully updated! " + msg
    else
      redirect_to points_path, alert: "Sorry, something went wrong :("
    end
  end

  def request_venue
    @request = current_user.user_efforts.new
  end

  def create_request_venue

  end

  # def edit
  #   @request = UserEffort.find(params[:id])
  #   @selectable = Effort::KINDS.map {|x| [ enum_title(x), Effort.find_by(name: enum_title(x)).id ] }
  # end

  # def update
  # end

  # def destroy
  # end

  private

  def request_params
    params.require(:user_effort).permit(:effort_id, :screenshot)
  end

  def location_params
    params.require(:share_location).permit(:preferred_location)
  end

  # def enum_title(symbol)
  #   symbol.to_s.gsub("_", " ").titleize
  # end

end
