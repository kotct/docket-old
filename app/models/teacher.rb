class Teacher < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: -> (controller, model) { controller && controller.current_user }

	validates :name, presence: true
	validates :email, format: { with: /\A[\w\-\.]+\@[\w\-\.]+\z/ }

	def first_name
		name.split(" ").first
	end

	def last_name
		name.split(" ").last
	end

	has_many :classrooms
end
