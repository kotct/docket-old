require 'spec_helper'

describe "User request" do

	describe "Create" do

		it "creates a user" do
			user = FactoryGirl.build(:user)
			visit new_user_path
			fill_in "Name", :with => user.name
			fill_in "Email", :with => user.email
			fill_in "Password", :with => user.password
			fill_in "Password confirmation", :with => user.password_confirmation
			click_button "Create"
			page.should_not have_content "fail"
			page.should have_content "created"
		end

		it "creates a bad user" do
			user = FactoryGirl.build(:user)
			visit new_user_path
			fill_in "Name", :with => user.name
			fill_in "Email", :with => user.email
			fill_in "Password", :with => user.password
			fill_in "Password confirmation", :with => user.password_confirmation + "no"
			click_button "Create"
			page.should have_content "Password"
			page.should have_content "error"
			page.should_not have_content "created"
			visit new_user_path # must revisit each time to clear fields
			fill_in "Email", :with => user.email
			fill_in "Password", :with => user.password
			fill_in "Password confirmation", :with => user.password_confirmation
			click_button "Create"
			page.should have_content "Name"
			page.should have_content "error"
			page.should_not have_content "created"
			visit new_user_path
			fill_in "Name", :with => user.name
			fill_in "Password", :with => user.password
			fill_in "Password confirmation", :with => user.password_confirmation
			click_button "Create"
			page.should have_content "Email"
			page.should have_content "error"
			page.should_not have_content "created"
			visit new_user_path
			user.save
			fill_in "Email", :with => user.email
			fill_in "Name", :with => user.name
			fill_in "Password", :with => user.password
			fill_in "Password confirmation", :with => user.password_confirmation
			click_button "Create"
			page.should have_content "Email"
			page.should have_content "taken"
			page.should have_content "error"
			page.should_not have_content "created"
		end

	end

	describe "Edit" do

		it "successfully edits a user" do
			user = FactoryGirl.create(:user)
			log_in(user)
			visit edit_user_url(user)
			page.should_not have_content "You are not logged in!"
			page.should_not have_content "permission"
			page.should have_content "Editing"
			click_button "Update"
			page.should have_content "successfully"
			visit log_out_path
			user_admin = FactoryGirl.create(:admin)
			log_in(user_admin)
			visit edit_user_url(user)
			page.should_not have_content "You are not logged in!"
			page.should_not have_content "permission"
			page.should have_content "Editing"
			click_button "Update"
			page.should have_content "successfully"
		end

		it "tries to edit a user" do
			user = FactoryGirl.create(:user)
			visit edit_user_url(user)
			page.should_not have_content "Editing"
			page.should have_content "You are not logged in!"
			user2 = FactoryGirl.create(:user)
			log_in(user2)
			visit edit_user_url(user)
			page.should_not have_content "Editing"
			page.should have_content "permission"
		end

	end

	describe "Show" do

		it "successfully shows a user" do
			user = FactoryGirl.create(:user)
			log_in(user)
			visit user_url(user)
			page.should_not have_content "You are not logged in!"
			page.should_not have_content "permission"
			page.should have_content user.name
			page.should have_content user.email
			page.should_not have_content user.password # D'oh
			visit log_out_path
			user_admin = FactoryGirl.create(:admin)
			log_in(user_admin)
			visit user_url(user)
			page.should_not have_content "You are not logged in!"
			page.should_not have_content "permission"
			page.should have_content user.name
			page.should have_content user.email
			page.should_not have_content user.password # D'oh
		end

		it "tries to show a user" do
			user = FactoryGirl.create(:user)
			visit user_url(user)
			page.should_not have_content user.name
			page.should_not have_content user.email
			page.should have_content "You are not logged in!"
			user2 = FactoryGirl.create(:user)
			log_in(user2)
			visit user_url(user)
			page.should_not have_content user.name
			page.should_not have_content user.email
			page.should have_content "permission"
		end

	end

	describe "Index" do

		it "successfully indexes all users" do
			user_admin = FactoryGirl.create(:admin)
			log_in(user_admin)
			visit users_path
			page.should_not have_content "You are not logged in!"
			page.should_not have_content "permission"
			page.should have_content "users"
		end

		it "tries to show a user" do
			visit users_path
			page.should_not have_content "Users"
			page.should have_content "You are not logged in!"
			user = FactoryGirl.create(:user)
			log_in(user)
			visit users_path
			page.should_not have_content "users"
			page.should have_content "permission"
		end

	end

end
