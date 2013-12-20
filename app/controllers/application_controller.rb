class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def current_user
		if session["current_user_id"]
			User.find session["current_user_id"]
		else
			nil
		end
	end

	def check_for_user
		redirect_to root_path, :alert => "You are not logged in!" unless current_user
	end
end
