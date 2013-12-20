class Classroom < ActiveRecord::Base
	belongs_to :teacher
	belongs_to :course
	has_many :assignments
	has_and_belongs_to_many :students
end
