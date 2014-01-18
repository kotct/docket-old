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
			begin
				user_find = User.find session["current_user_id"]
			rescue Exception => e
				puts "Exception occurred (#{e.message})"

				nil
			end

			user_find
		else
			nil
		end
	end

	def generate_glyphicon(spclass = "", glyphicon_name)
		content_tag(:span, :class => "#{spclass} glyphicon glyphicon-#{glyphicon_name}") do
		end
	end
end
