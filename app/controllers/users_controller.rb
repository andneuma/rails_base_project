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

    if @user.save
      redeem_activation_token
      redirect_to root_url
    else
      render json: @user.errors.full_messages, status: :bad_request
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      render json: @user.to_json, status: :ok
    else
      render json: @user.errors.full_messages, status: :bad_request
    end
  end

  def destroy
    @user = User.find(params[:id])

    if try_deleting_own_user?
      @user.destroy && logout

      redirect_to root_url
    else
      render json: nil, status: :forbidden
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation
    )
  end

  # Restrict access to record only if comes from same user
  def same_user_origin
    redirect_to root_url unless current_user.id == @user.id
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def redeem_activation_token
    @token.update_attributes(redeemed: true)
  end

  def needs_valid_token
    @token = ActivationToken.find_by(token: params[:activation_token])
    render json: nil, status: :unauthorized unless @token.present?
  end
end
