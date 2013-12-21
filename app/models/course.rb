class Course < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: -> (controller, model) { controller && controller.current_user }

	validates :name, presence: true, uniqueness: true
	
	has_many :classrooms
end
