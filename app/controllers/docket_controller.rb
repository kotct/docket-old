class DocketController < ApplicationController
	skip_authorization_check

	def index
		redirect_to log_in_path, notice: "Please log in to use Docket." unless current_user

		@current_day = Date.today
		@days_of_this_week = view_context.get_day_array(@current_day, :week)
	end
end
