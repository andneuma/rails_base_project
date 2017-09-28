class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:destroy, :toggle_activation]

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)

    if @user.save
      activate_user
      render json: @user.to_json, status: :ok
    else
      render json: @user.errors.full_messages, status: :bad_request
    end
  end

  def toggle_activation
    new_val = !@user.activated

    if @user.update_attributes(activated: new_val)
      render json: @user.to_json, status: :ok
    end
  end

  def destroy
    unless try_deleting_own_user?
      @user.destroy
      render :index
    end
  end

  private

  def try_deleting_own_user?
    if @user == current_user
      render status: :forbidden, json: nil
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def activate_user
    @user.update_attributes(activated: true)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
