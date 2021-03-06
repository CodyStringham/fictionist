class ContentsController < ApplicationController
  before_action :find_content, only: [:show, :purchase, :redeem_points, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :purchase]

  def index
    @contents = Content.all
  end

  def show
    unless @content.users.any? {|x| x == current_user} || @content.view_permission == "free"
      redirect_to purchase_content_path(@content.id)
    end
  end

  def purchase
    # This allows us to explain things on the purcahse page without being signed in
    @redemption = current_user ? current_user.redemptions.new() : :redemptions
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
      redirect_to contents_path, notice: 'content was updated.'
    else
      render 'edit'
    end
  end

  def destroy
    if @content.delete
      redirect_to contents_path, notice: "deleted"
    else
      render :edit
    end
  end

  private

  def find_content
    @content = Content.find(params[:id])
  end

  def content_params
    params.require(:content).permit(:message, :asset, :thumbnail, :view_permission, :value, :asset_type, :uploader_id, :location, :embed_link)
  end

end
