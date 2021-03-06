class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, only: [:index]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :finish_signup, :update_points]

  def index
    @users = User.all
    @new_user = User.new
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, alert: "Access denied."
      end
    end
  end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
  end

  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user
    if @user.update(user_params)
      sign_in(@user == current_user ? @user : current_user, bypass: true)
      redirect_to @user, notice: 'Your profile was successfully updated.'
    else
      render 'edit'
    end
  end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user
    if request.patch? && user_params[:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, bypass: true)
        redirect_to root_path, notice: 'A confirmation has been sent to your email, please confirm to sign in!'
      else
        @show_errors = true
      end
    end
  end

  def update_points
    if params[:points][:point_action] == 'add_points'
      @user.points += params[:points][:points].to_i
    else
      @user.points -= params[:points][:points].to_i
    end

    if @user.save
      redirect_to users_path, notice: 'Points were successfully updated!'
    else
      redirect_to users_path, alert: "Something went wrong, sorry. #{@user.errors.full_messages}"
    end
  end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end

  def invite_new_user
    user = User.invite!(email: params[:user][:email], name: params[:user][:name])
    user.update_attribute(:invited_by_id, current_user.id)
    redirect_to root_path, notice: "user was invited"
  end

  private

  def admin_only
    unless current_user.admin? || current_user.band_member?
      redirect_to root_path, alert: "Access denied."
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    accessible = [ :name, :email ] # extend with your own params
    accessible << [ :password, :password_confirmation ]
    accessible << [ :role, :points, :point_action ] if current_user.admin?
    params.require(:user).permit(accessible)
  end

end
