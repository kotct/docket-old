FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Person#{n} Tester" }
		sequence(:email) { |n| "fooo#{n}@example.com" }
		password "secret"
		password_confirmation "secret"
		factory :admin do
			admin true
		end
	end
end
