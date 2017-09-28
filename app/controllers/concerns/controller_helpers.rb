# Set of methods usable throughout all controllers
module ControllerHelpers
  extend ActiveSupport::Concern
  attr_accessor :model

  included do
    helper_method :logout
    helper_method :current_user
    helper_method :require_login
    helper_method :require_admin
  end

  def logout
    session[:user_id] = nil
  end

  def require_login
    current_user.present?
  end

  def require_admin
    unless current_user.admin?
      not_found && false 
    end
  end

  def current_user
    @current_user ||= if user = User.find_by(id: session[:user_id])
                        user
                      else
                        GuestUser.new
                      end
  end

  private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
