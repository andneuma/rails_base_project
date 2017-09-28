class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:destroy, :toggle_activation]

  def index
    @users = User.all
		respond_to do |format|
			format.html
      format.json { render json: @users.to_json, status: :ok}
    end
  end

  def new
    @user = User.new

		respond_to do |format|
			format.html
      format.json { render json: @user.to_json, status: :ok}
    end
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        activate_user
				format.json { render json: @user.to_json, status: :ok }
				format.html do
          flash[:success] = "User created successfully"
          redirect_to admin_index_users_path
        end
      else
        format.json { render json: @user.errors.full_messages, status: :bad_request }
        format.html do
          flash[:success] = @user.errors.full_messages.to_sentence
					render :new
        end

      end
    end
  end

  def toggle_activation
    new_val = !@user.activated

    if @user.update_attributes(activated: new_val)
      respond_to do |format|
        format.json { render json: @user.to_json, status: :ok }
        format.html { redirect_to admin_index_users_path }
      end
    end
  end

  def destroy
    unless try_deleting_own_user?
      @user.destroy
      respond_to do |format|
				format.json { render json: nil, status: :ok}
        format.html { redirect_to admin_index_users_path }
      end
    end
  end

  private

  def try_deleting_own_user?
    if @user == current_user
			respond_to do |format|
				format.html do
          flash[:danger] = "You cannot delete yourself via this interface!"
          redirect_to admin_index_users_path
        end
        format.json { render status: :forbidden, json: nil }
      end
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
