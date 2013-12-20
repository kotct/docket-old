class User < ActiveRecord::Base
	has_and_belongs_to_many :classrooms

	validates_presence_of :password, :on => :create
	has_secure_password
end
