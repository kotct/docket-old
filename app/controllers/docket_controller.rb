class DocketController < ApplicationController
	skip_authorization_check
	def index
		redirect_to log_in_path, notice: "Please log in to use Docket." unless current_user

		@today_and_tomorrow_exams = []
		@other_exams = []
		current_user.exams.each do |e|
			case 
			when ((e.date == Date.today) or (e.date == Date.today + 1.day))
				@today_and_tomorrow_exams << e
			when e.date > Date.today + 1.day
				@other_exams << e
			end
		end

		@today_and_tomorrow_assignments = []
		@other_assignments = []
		current_user.assignments.each do |e|
			case 
			when ((e.due_date == Date.today) or (e.due_date == Date.today + 1.day))
				@today_and_tomorrow_assignments << e
			when e.due_date > Date.today + 1.day
				@other_assignments << e
			end
		end

		@today_and_tomorrow_events = []
		@other_events = []
		current_user.events.each do |e|
			case 
			when ((e.date == Date.today) or (e.date == Date.today + 1.day))
				@today_and_tomorrow_events << e
			when e.date > Date.today + 1.day
				@other_events << e
			end
		end

		@other_things = (@other_assignments + @other_exams + @other_events).sort do |thing1, thing2|
			relevant_date(thing1) <=> relevant_date(thing2)
		end
	end
end
