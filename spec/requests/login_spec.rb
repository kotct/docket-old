require 'spec_helper'

describe "LogIn" do
	describe "LogInUser" do
		it "logs in a user" do
			user = FactoryGirl.create(:user)
			log_in user
			page.should have_content "Logged in!"
			page.should have_content user.name
		end
	end

	describe "BadLogInUser" do
		it "logs in a user with the incorrect password" do
			user = FactoryGirl.create(:user)
			visit log_in_path
			fill_in "Email", :with => user.email
			fill_in "Password", :with => user.password + "no"
			click_button "Log in"
			page.should have_content "Fail"
			page.should_not have_content "Logged in!"
		end
	end
end
