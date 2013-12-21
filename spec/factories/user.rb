FactoryGirl.define do
	factory :user do
		name "Tester Person"
		sequence(:email) { |n| "fooo#{n}@example.com" }
		password "secret"
		password_confirmation "secret"
	end
end
