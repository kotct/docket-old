module ApplicationHelper
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
