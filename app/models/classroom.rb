class Classroom < ActiveRecord::Base

	def name
		course.name + " period " + period.to_s + " - " + teacher.name
	end
	
	belongs_to :teacher
	belongs_to :course
	has_many :assignments
	has_many :exams
	has_many :memberships
	has_many :students, :through => :memberships
end
