class UploadsController < ApplicationController
  before_action :find_content, only: [:show, :edit, :update, :destroy]
  def index
    @contents = Content.all
  end

  def show
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
  end

  def update
    if @content.update(content_params)
      redirect_to root_path, notice: 'content was updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @content.delete
  end

  private

  def find_content
    @content = Content.find(params[:id])
  end

  def content_params
    params.require(:content).permit(:message, :asset, :view_permission, :value, :asset_type, :uploader_id, :location)
  end

end
