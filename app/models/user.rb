class User < ActiveRecord::Base
	validates :password, presence: true, on: :create
	validates :email, presence: true, uniqueness: true
	validates :name, presence: true

	validates_format_of :email, :with => /\A[\w\-\.]+\@[\w\-\.]+\z/

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

	has_many :memberships
	has_many :classrooms, :through => :memberships
	has_many :attendances
	has_many :events, :through => :attendances
end
