module ClassroomsHelper
	def sort_by_period(classrooms)
		return classrooms.sort! { |first, last| first.period <=> last.period }
	end
end
