class UploadsController < ApplicationController

  def index
    @contents = Content.all
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

  def edit
    @content = Content.find(params[:id])
  end

  def update
    @content = Content.find(params[:id])
    if @content.update(content_params)
      redirect_to root_path, notice: 'content was updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @content = Content.find(params[:id])
    @content.delete
  end

  private

  def content_params
    params.require(:content).permit(:message, :asset, :view_permission, :value, :asset_type, :uploader_id, :location)
  end

end
