module ApplicationHelper
	def relevant_date(thing)
		case
		when thing.class == Assignment
			thing.due_date
		when thing.class == Exam
			thing.date
		when thing.class == Event
			thing.date
		else
			throw "That's not a assignment or exam, its a " + thing.class.to_s
			Date.new(1970, 1, 1)
		end
	end

	def current_user
		if session["current_user_id"]
			User.find session["current_user_id"]
		else
			nil
		end
	end

	def day_assignments(day)
		current_user.assignments.select {|assignment| assignment.due_date == day}
	end

	def day_exams(day)
		current_user.exams.select {|exam| exam.date == day}
	end

	def day_events(day)
		current_user.events.select {|event| event.date == day}
	end
end
