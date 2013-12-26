class Classroom < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: -> (controller, model) { controller && controller.current_user }

	validates :period, presence: true, uniqueness: {scope: [:course_id, :teacher_id]}
	validates :course_name, presence: true
	validates :teacher_name, presence: true

	def information
		course.name + " -- " + period.ordinalize + " hour" + " -- " + teacher.name
	end

	def course_name
		course.name if course
	end

	def course_name=(name)
		self.course = Course.find_or_create_by_name(name) unless name.blank?
	end

	def teacher_name
		teacher.name if teacher
	end

	def teacher_name=(name)
		self.teacher = Teacher.find_or_create_by_name(name) unless name.blank?
	end

	belongs_to :teacher
	belongs_to :course
	has_many :assignments
	has_many :exams
	has_many :memberships
	has_many :users, :through => :memberships
end
