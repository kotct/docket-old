class Ability
	include CanCan::Ability

	def initialize(user)
		logged_in = true if user
		user ||= User.new # guest user (not logged in)

		# The first argument to `can` is the action you are giving the user 
		# permission to do.
		# If you pass :manage it will apply to every action. Other common actions
		# here are :read, :create, :update and :destroy.
		#
		# The second argument is the resource the user can perform the action on. 
		# If you pass :all it will apply to every resource. Otherwise pass a Ruby
		# class of the resource.
		#
		# The third argument is an optional hash of conditions to further filter the
		# objects.
		# For example, here the user can only update published articles.
		#
		#   can :update, Article, :published => true
		#
		# See the wiki for details:
		# https://github.com/ryanb/cancan/wiki/Defining-Abilities

		if user.admin?
			can :manage, :all
		else
			can :create, User
		end

		if logged_in
			can :manage, User, :id => user.id
			can :manage, Classroom
			can :manage, Membership
			can :manage, Event
			can :manage, Teacher
			can :manage, Course
			
			can :read, Assignment
			can :create, Assignment
			
			can :manage, Assignment.all do |assignment|
				assignment.classroom.users.include? user
			end
			
			can :read, Exam
			can :create, Exam

			can :manage, Exam.all do |exam|
				exam.classroom.users.include? user
			end
		end

	end

end
