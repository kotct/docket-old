class Membership < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: -> (controller, model) { controller && controller.current_user }
	
	belongs_to :classroom
	belongs_to :user
end
