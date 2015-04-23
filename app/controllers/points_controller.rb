class PointsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pending = current_user.user_efforts.pending
    @new_user = User.new
  end

  def new
    @request = current_user.user_efforts.new
    # makes [ "Effort Name", 42 ] for select
    @selectable = Effort::KINDS.map {|x| [ enum_title(x), Effort.find_by(name: enum_title(x)).id ] }
  end

  def share_location
    @request = current_user.user_efforts.new
  end

  def request_venue
    @request = current_user.user_efforts.new
  end

  def create
    @request = current_user.user_efforts.new(request_params)
    if @request.save
      redirect_to root_path, notice: 'Points were requested.'
    else
      render 'new'
    end
  end

  def edit
    @request = UserEffort.find(params[:id])
    @selectable = Effort::KINDS.map {|x| [ enum_title(x), Effort.find_by(name: enum_title(x)).id ] }
  end

  def update
  end

  def destroy
  end

  private

  def request_params
    params.require(:user_effort).permit(:effort_id, :screenshot)
  end

  def enum_title(symbol)
    symbol.to_s.gsub("_", " ").titleize
  end

end
