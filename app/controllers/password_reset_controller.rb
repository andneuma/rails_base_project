class PasswordResetController < ApplicationController
  before_action :require_login
  before_action :set_user, only: [:reset_password, :set_new_password]
  before_action :set_user_by_email, only: [:create_password_reset]
  before_action :authenticated?, only: [:reset_password, :set_new_password]

  def request_password_reset
  end
  
  def create_password_reset
    if @user.create_digest_for(attribute: 'password_reset') && @user.save
      UserMailer.send_password_reset_link(@user).deliver_now
      redirect_to login_path
    end
  end

  def reset_password
    render 'password_reset_form', locals: { password_reset_token: params[:token], user_id: @user.id }
  end

  def set_new_password
    if passwords_match?
      new_password = params[:new_password][:password]
      @user.update_attributes(password: new_password,
                               password_confirmation: new_password,
                               password_reset_digest: nil) 
      redirect_to root_url
    else
      reset_password
    end
  end

  private

  def set_user_by_email
    unless @user = User.find_by(email: params[:password_reset][:email])
      redirect_to :request_password_reset
    end
  end

  def set_user
    @user = User.find_by(id: params[:id]) 
  end

  def authenticated?
    unless @user && token_valid? 
      redirect_to root_url
    end
  end

  def token_valid?
    @user.authenticated?(attribute: :password_reset, token: params[:token]) && @user.password_reset_token_alive?

  end
  def passwords_match?
    params[:new_password][:password] == params[:new_password][:password_confirmation]
  end
end
