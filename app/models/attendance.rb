class Attendance < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: -> (controller, model) { controller && controller.current_user }

	validates :event_id, presence: true
	validates :user_id, presence: true, uniqueness: {scope: :event_id}

	belongs_to :event
	belongs_to :user
end
