class SessionsController < ApplicationController
  before_action :set_user, only: [:create]

  def create
    if @user && creds_valid?
      session[:user_id] = @user.id
      # render status: :ok, json: @user.slice(:name, :email).to_json
			redirect_to root_url
    else
      render status: :unauthorized, json: nil
    end
  end

  def destroy
    session[:user_id] = nil
    # render status: :ok, json: nil
		redirect_to root_url
  end

  private

  def creds_valid?
    @user.authenticated?(attribute: :password, token: params[:session][:password])
  end

  def set_user
    @user = User.find_by_email(params[:session][:email]) ||
						User.find_by_name(params[:session][:name])
    unless @user && @user.activated
      # render status: :unauthorized, json: nil
			redirect_to login_url
    end
  end
end
