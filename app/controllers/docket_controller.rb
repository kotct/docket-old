class DocketController < ApplicationController
	skip_authorization_check

	def index
		redirect_to log_in_path, notice: "Please log in to use Docket." unless current_user

		@current_day = Date.today
		@days_of_this_week = []

		difference_between_today_and_start_of_week = @current_day.wday
		start_of_week = @current_day - difference_between_today_and_start_of_week.days

		(0..6).each do |wnum|
			@days_of_this_week << start_of_week + wnum.days
		end

		start_of_other_range = @days_of_this_week.last

		@this_week_exams = []
		@other_exams = []

		current_user.exams.each do |e|
			case
			when (@days_of_this_week.include? e.date)
				@this_week_exams << e
			when (e.date > start_of_other_range)
				@other_exams << e
			end
		end

		@this_week_assignments = []
		@other_assignments = []

		current_user.assignments.each do |e|
			case
			when (@days_of_this_week.include? e.due_date)
				@this_week_assignments << e
			when (e.due_date > start_of_other_range)
				@other_assignments << e
			end
		end

		@this_week_events = []
		@other_events = []

		relevant_events = (current_user.events + Event.where(:global => true)).uniq

		relevant_events.each do |e|
			case
			when (@days_of_this_week.include? e.date)
				@this_week_events << e
			when (e.date > start_of_other_range)
				@other_events << e
			end
		end

		@other_things = (@other_assignments + @other_exams + @other_events).sort do |thing1, thing2|
			view_context.relevant_date(thing1) <=> view_context.relevant_date(thing2)
		end
	end
end
