class User < ActiveRecord::Base
	validates :password, presence: true, on: :create
	validates :email, presence: true, uniqueness: true
	validates :name, presence: true
	
	has_secure_password

	has_and_belongs_to_many :classrooms
end
