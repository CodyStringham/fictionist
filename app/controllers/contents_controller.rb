class ContentsController < ApplicationController
  before_action :find_content, only: [:show, :purchase, :redeem_points, :edit, :update, :destroy]

  def index
    @contents = Content.all
  end

  def show
    unless @content.users.any? {|x| x == current_user}
      redirect_to purchase_content_path(@content.id)
    end
  end

  def purchase
    @redemption = current_user.redemptions.new()
  end

  def redeem_points
    @redemption = current_user.redemptions.new(content_id: @content.id, value: @content.value)
    if @redemption.save
      redirect_to user_path(current_user.id), notice: "Content unlocked!"
    else
      redirect_to purchase_content_path(@content.id), alert: "#{@redemption.errors.first.pop}"
    end
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
