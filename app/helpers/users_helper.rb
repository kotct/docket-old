module UsersHelper
	def sort_by_period(list)
		list.sort! { |first, last| first.period <=> last.period }
	end
end
