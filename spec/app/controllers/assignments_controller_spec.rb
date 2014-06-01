require "spec_helper"

describe AssignmentsController do
	describe "GET 'index'" do
		it "Returns HTTP Success" do
			get "index"
			response.should be_success
		end
	end
end
