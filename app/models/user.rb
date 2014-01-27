class User < ActiveRecord::Base
	validates :password, presence: true, on: :create
	validates :email, presence: true, uniqueness: true, format: { with: /\A[\w\-\.]+\@[\w\-\.]+\z/ }
	validates :name, presence: true

	has_secure_password

	def assignments
		ret = []

		self.classrooms.each do |c|
			ret += c.assignments
		end

		ret
	end

	def exams
		ret = []

		self.classrooms.each do |c|
			ret += c.exams
		end

		ret
	end

	def day_assignments(day)
		self.assignments.select { |assignment| assignment.due_date == day }
	end

	def day_exams(day)
		self.exams.select { |exam| exam.date == day }
	end

	def day_events(day)
		all_events = (self.events + Event.where(:global => true)).uniq

		# Select events from a certain day.
		day_events = all_events.select { |event|
			event.date.to_date == day
		}

		# Sort these events by date.
		day_events.sort! { |first,last|
			first.date <=> last.date
		}

		return day_events
	end

	def classes
		self.classrooms
	end

	def classes_with_activities_on(day)
		self.classrooms.select { |classroom| classroom.day_activities(day).count > 0 }
	end

	def classes_with_assignments_on(day)
		self.classrooms.select { |classroom| classroom.day_assignments(day).count > 0 }
	end

	def classes_with_exams_on(day)
		self.classrooms.select { |classroom| classroom.day_exams(day).count > 0 }
	end

	has_many :memberships
	has_many :classrooms, :through => :memberships
	has_many :attendances
	has_many :events, :through => :attendances

	has_one :configuration
end
