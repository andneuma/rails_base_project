class ApplicationController < ActionController::Base
  include ControllerHelpers

  protect_from_forgery with: :exception

	def landing
		render 'layouts/landing'
	end
end
