module ApplicationHelper
	def relevant_date(thing)
		case
		when thing.class == Assignment
			thing.due_date
		when thing.class == Exam
			thing.date
		else
			throw "that's not a assignment or exam, its a " + thing.class.to_s
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

	def nav_link(link_text, url, controller)
		class_name = (params[:controller] == controller) ? 'active' : ''

		content_tag(:li, :class => class_name) do
			link_to link_text, url
		end
	end
end
