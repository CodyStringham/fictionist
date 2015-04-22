class EffortsController < ApplicationController

  def index
    @efforts = Effort.all
  end

  # def new
  #   @effort = current_user.efforts.new
  # end

  # def create
  #   @effort = current_user.efforts.new(effort_params)
  #   if @effort.save
  #     redirect_to root_path, notice: 'Points were requested.'
  #   else
  #     render 'new'
  #   end
  # end

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
