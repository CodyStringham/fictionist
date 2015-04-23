class EffortsController < ApplicationController

  def index
    @efforts = Effort.all
  end

  def award
    @pending = UserEffort.where(status: "pending")
  end

  def approve
    @user = User.find(params[:user_id])
    if @user.user_efforts.find(params[:user_effort]).approve
      redirect_to award_path, notice: "Approved!"
    else
      render 'award', notice: "Error. Could not be Approved :("
    end
  end

  def decline
    @user = User.find(params[:user_id])
    if @user.user_efforts.find(params[:user_effort]).decline
      redirect_to award_path, notice: "Declined!"
    else
      render 'award', notice: "Error. Could not be Declined :("
    end
  end

  def edit
    @effort = Effort.find(params[:id])
  end

  def update
    @effort = Effort.find(params[:id])
    if @effort.update(effort_params)
      redirect_to efforts_path, notice: "Effort value was updated."
    else
      render 'edit'
    end
  end

  private

  def effort_params
    params.require(:effort).permit(:value)
  end

end
