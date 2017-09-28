class SessionsController < ApplicationController
  before_action :set_user, only: [:create]

  def create
    respond_to do |format|
      if @user && creds_valid?
        session[:user_id] = @user.id
        format.html do
					flash[:success] = "Welcome #{@user.name}!"
					redirect_to root_url
				end
				format.json { render status: :ok, json: @users.slice(:name, :email).to_json }
      else
				format.html do
					flash[:danger] = "Password and username do not match!"
					redirect_to login_path
				end
				format.json { render status: :unauthorized, json: nil }
      end
    end
  end

  def destroy
    session[:user_id] = nil
		respond_to do |format|
			format.html do
				flash[:warning] = "Goodbye!"
				redirect_to root_url
			end
			format.json { render status: :ok, json: nil }
		end
  end

  private

  def creds_valid?
    @user.authenticated?(attribute: :password, token: params[:session][:password])
  end

  def set_user
    @user = User.find_by_email(params[:session][:email]) ||
						User.find_by_name(params[:session][:name])

		unless @user && @user.activated
			respond_to do |format|
				format.json { render status: :unauthorized, json: nil }
				format.html do
					flash[:warning] = "Your user account needs to be activated first!"
					redirect_to login_url
				end
			end
		end
	end
end
