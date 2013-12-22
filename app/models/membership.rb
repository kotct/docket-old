class Membership < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: -> (controller, model) { controller && controller.current_user }

	validates :classroom_id, presence: true
	validates :user_id, presence: true, uniqueness: {scope: :classroom_id}
	
	belongs_to :classroom
	belongs_to :user
end
