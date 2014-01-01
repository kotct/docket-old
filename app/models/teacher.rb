class Teacher < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: -> (controller, model) { controller && controller.current_user }

	def last_name
		name.split.last
	end

	has_many :classrooms
end
