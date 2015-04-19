class UploadsController < ApplicationController

  def index
    @contents = current_user.uploaded_contents
  end

  def new
    @content = current_user.uploaded_contents.new
  end

  def create
    @content = current_user.uploaded_contents.new(content_params)
    if @content.save
      redirect_to root_path, notice: 'content was created.'
    else
      render 'new'
    end
  end

  private

  def content_params
    params.require(:content).permit(:message, :asset, :view_permission, :value)
  end

end
