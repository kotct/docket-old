class Teacher < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: -> (controller, model) { controller && controller.current_user }

	validates :name, presence: true

	validates_format_of :email, with: /\A[\w\-\.]+\@[\w\-\.]+\z/

	def last_name
		name.split.last
	end

	has_many :classrooms
end
