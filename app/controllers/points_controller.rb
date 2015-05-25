class PointsController < ApplicationController
  before_action :authenticate_user!
  before_action :gather_efforts, only: :index

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
      redirect_to points_path, notice: 'Points were requested.'
    else
      errors = ""
      @request.errors.full_messages.each {|x| errors += "#{x} "}
      redirect_to new_point_path(params[:effort_id]), alert: errors
    end
  end

  def share_location
  end

  def create_share_location
    if current_user.preferred_location.nil?
      current_user.update_attributes(points: current_user.points + Effort.where(kind: Effort.kinds[:share_location]).first.value)
    end
    if current_user.update_attributes(location_params)
      msg = current_user.preferred_location.nil? ? "You recieved points for sharing!" : "Thanks for the update, you already recieved points for this!"
      redirect_to points_path, notice: "Your preferred location was successfully updated! " + msg
    else
      redirect_to points_path, alert: "Sorry, something went wrong :("
    end
  end

  def request_venue
    @request = current_user.user_efforts.new
  end

  def create_request_venue
    if current_user.requested_venue.nil?
      current_user.update_attributes(points: current_user.points + Effort.where(kind: Effort.kinds[:request_venue]).first.value)
    end
    if current_user.update_attributes(venue_params)
      msg = current_user.requested_venue.nil? ? "You recieved points for requesting a venue!" : "Thanks for the update, you already recieved points for this!"
      redirect_to points_path, notice: "Your requested venue was successfully updated! " + msg
    else
      redirect_to points_path, alert: "Sorry, something went wrong :("
    end
  end

  private

  def request_params
    params.require(:user_effort).permit(:effort_id, :screenshot)
  end

  def location_params
    params.require(:share_location).permit(:preferred_location)
  end

  def venue_params
    params.require(:request_venue).permit(:requested_venue)
  end

  def gather_efforts
    @spotify_playlist = Effort.where(kind: Effort.kinds[:spotify_playlist]).first.id
    @blog_post = Effort.where(kind: Effort.kinds[:blog_post]).first.id
    @facebook_post = Effort.where(kind: Effort.kinds[:facebook_post]).first.id
    @twitter_post = Effort.where(kind: Effort.kinds[:twitter_post]).first.id
    @instagram_post = Effort.where(kind: Effort.kinds[:instagram_post]).first.id
    @youtube_post = Effort.where(kind: Effort.kinds[:youtube_post]).first.id

    @facebook_like = Effort.where(kind: Effort.kinds[:facebook_like]).first.id
    @twitter_like = Effort.where(kind: Effort.kinds[:twitter_like]).first.id
    @instagram_like = Effort.where(kind: Effort.kinds[:instagram_like]).first.id
    @youtube_like = Effort.where(kind: Effort.kinds[:youtube_like]).first.id
  end

end
