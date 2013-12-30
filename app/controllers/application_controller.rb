class ApplicationController < ActionController::Base
	check_authorization
	include PublicActivity::StoreController

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_filter :check_for_user_if_not_session_controller

	def current_user
		if session["current_user_id"]
			User.find session["current_user_id"]
		else
			nil
		end
	end
	hide_action :current_user

	def admin?
		current_user.admin if current_user
	end

	def check_for_user
		redirect_to log_in_path, alert: "You are not logged in!" unless current_user
	end

	def check_for_user_if_not_session_controller
		check_for_user unless (params[:controller] == "sessions" || params[:controller] == "users")
	end

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to root_url, :alert => exception.message
	end

end
