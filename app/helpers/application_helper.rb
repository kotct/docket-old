module ApplicationHelper
	def current_user
		if session["current_user_id"]
			User.find session["current_user_id"]
		else
			nil
		end
	end
end
