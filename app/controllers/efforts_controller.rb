class EffortsController < ApplicationController
  respond_to :js, :html

  before_action :get_effort, only: [:edit, :update]
  before_action :get_pending, only: :award

  def index
    @efforts = Effort.all
  end

  def award
  end

  def approve
    @user = User.find(params[:user_id])
    if @user.user_efforts.find(params[:user_effort]).approve
      respond_to do |format|
        format.html { redirect_to award_path, notice: 'Approved!' }
        format.js { get_pending }
       end
    else
      render 'award', alert: "Error. Could not be Approved :("
    end
  end

  def decline
    @user = User.find(params[:user_id])
    if @user.user_efforts.find(params[:user_effort]).decline
      respond_to do |format|
        format.html { redirect_to award_path, alert: "Declined!" }
        format.js { get_pending }
       end
    else
      render 'award', alert: "Error. Could not be Declined :("
    end
  end

  def edit
  end

  def update
    if @effort.update(effort_params)
      redirect_to efforts_path, notice: "Effort value was updated."
    else
      render 'edit'
    end
  end

  private

  def effort_params
    params.require(:effort).permit(:desc, :value)
  end

  def get_pending
    @pending = UserEffort.where(status: "pending")
  end

  def get_effort
    @effort = Effort.find(params[:id])
  end

end
