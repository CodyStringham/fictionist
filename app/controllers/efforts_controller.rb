class EffortsController < ApplicationController

  def index
    @efforts = Effort.all
  end

  def award
    @pending = UserEffort.where(status: "pending")
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
