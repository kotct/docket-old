class Event < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: -> (controller, model) { controller && controller.current_user }
end
