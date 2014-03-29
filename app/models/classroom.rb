class Classroom < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: -> (controller, model) { controller && controller.current_user }

	validates :period, presence: true, uniqueness: { scope: [:course_id, :teacher_id] }
	validates :course_name, :teacher_name, presence: true

	def name(html = false)
		if html
			return ("<span id=\"course-period-span\" class=\"course-info-span\">" +
			        "#{period.ordinalize} hour" +
			        "</span>" + " " +

			        "<span id=\"course-course-name-span\" class=\"course-info-span\">" +
			        "#{course.name} class" +
			        "</span>" + ", taught by " +

			        "<span id=\"course-teacher-name-span\" class=\"course-info-span\">" +
			        "#{teacher.name}" +
			        "</span>").html_safe
		else
			return ("#{period.ordinalize} hour #{course.name}: #{teacher.name}")
		end
	end

	alias_method :information, :name

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

	def day_assignments(day)
		self.assignments.select {|assignment| assignment.due_date == day}
	end

	def day_exams(day)
		self.exams.select {|exam| exam.date == day}
	end

	def day_activities(day)
		self.day_assignments(day) + self.day_exams(day)
	end

	belongs_to :teacher
	belongs_to :course
	has_many :assignments
	has_many :exams
	has_many :memberships
	has_many :users, :through => :memberships
end
