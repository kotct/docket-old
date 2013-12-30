class SessionsController < ApplicationController
	skip_authorization_check

	def new
		if current_user
			redirect_to root_path, :notice => "You are already logged in!"
		end
	end

	def create
		fail_message = "Failed log in!"
		success_message = "Logged in!"

		users = User.where :email => params["email"]

		if users.count > 0
			@user = users.first

			if @user.authenticate params["password"]
				session["current_user_id"] = @user.id

				redirect_to root_path, :notice => success_message
			else
				redirect_to sessions_new_path, :alert => fail_message
			end
		else
			redirect_to sessions_new_path, :alert => fail_message
		end
	end

	def destroy
		session["current_user_id"] = nil

		redirect_to root_path
	end
end
