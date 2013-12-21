class Classroom < ActiveRecord::Base
	belongs_to :teacher
	belongs_to :course
	has_many :assignments
	has_many :memberships
	has_many :students, :through => :memberships
end
