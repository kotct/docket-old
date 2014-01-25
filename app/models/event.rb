class Event < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: -> (controller, model) { controller && controller.current_user }

	has_many :attendances
	has_many :users, :through => :attendances

	def global?
		self.global
	end
end
