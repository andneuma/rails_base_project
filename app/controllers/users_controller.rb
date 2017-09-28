class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :same_user_origin, only: [:edit, :update, :destroy]
  before_action :needs_valid_token, only: [:create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

		respond_to do |format|
			if @user.save
				redeem_activation_token

				format.json { render json: @user.to_json, status: :success}
				format.html do
					flash[:success] = "User successfully created"
					redirect_to root_url
				end
			else
				format.json { render json: @user.errors.full_messages, status: :bad_request }
				format.html do
					flash[:danger] = @user.errors.full_messages.to_sentence
					render :new
				end
			end
		end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
				format.json { render json: @user.to_json, status: :success }
        format.html do
					redirect_to edit_user_path(id: @user.id)
          flash[:success] = 'Successfully updated your users preferences'
        end
      else
        format.json { render json: @user.errors.full_messages, status: :bad_request }
				format.html do
					render :edit
					flash[:danger] = @user.errors.full_messages.to_sentence
				end
      end
    end
  end

  def destroy
    @user = User.find(params[:id])

		respond_to do |format|
			if try_deleting_own_user?
				@user.destroy && logout

				format.json { render json: nil, status: :success}
				format.html do
					flash[:warning] = "You have just deleted your own account!"
					redirect_to root_url
				end
			else
				format.json { render json: nil, status: :forbidden }
				format.html { head :forbidden }
			end
		end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation
    )
  end

  # Restrict access to record only if comes from same users
  def same_user_origin
		unless current_user.id == @user.id
			respond_to do |format|
				format.html { redirect_to root_url }
				format.json { render json: nil, status: :forbidden }
			end
		end
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def redeem_activation_token
    @token.update_attributes(redeemed: true)
  end

  def needs_valid_token
    @token = ActivationToken.find_by(token: params[:activation_token])

		unless @token.present?
			respond_to do |format|
				format.json { render json: nil, status: :unauthorized }
				format.html { render :new }
			end
		end
	end

	def try_deleting_own_user?
		@user == current_user
	end
end
