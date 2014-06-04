class UsersController < ApplicationController
	load_and_authorize_resource
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	# GET /users
	# GET /users.json
	def index
		@users = User.all

		respond_to do |format|
			format.html
			format.json { render json: @users.map(&:as_json) }
		end
	end

	# GET /users/1
	# GET /users/1.json
	def show
		respond_to do |format|
			format.html
			format.json { render json: @user.as_json }
		end
	end

	# GET /users/new
	def new
		@user = User.new
	end

	# GET /users/1/edit
	def edit
	end

	# POST /users
	# POST /users.json
	def create
		@user = User.new(user_params)

		@user.admin = nil unless admin?

		respond_to do |format|
			if @user.save
				format.html { redirect_to log_in_path, notice: "User was successfully created." }
				format.json { render action: "show", status: :created, location: @user }
			else
				format.html { render action: "new" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /users/1
	# PATCH/PUT /users/1.json
	def update
		@user.admin = nil unless admin?

		respond_to do |format|
			if @user.update(user_params)
				format.html { redirect_to @user, notice: "User was successfully updated." }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /users/1
	# DELETE /users/1.json
	def destroy
		# Log out before deleting user if logged in as user to be deleted.
		session["current_user_id"] = nil if session["current_user_id"] == @user.id

		@user.destroy

		respond_to do |format|
			format.html { redirect_to users_url }
			format.json { head :no_content }
		end
	end

	# GET /users/1/activity
	def activity
		@user = User.find(params[:id])
		@activities = PublicActivity::Activity.where(:owner_id => @user.id).order("created_at desc")
	end

	# GET /users/activity
	def index_activities
		@activities = PublicActivity::Activity.order("created_at desc")
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_user
		@user = User.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def user_params
		params.require(:user).permit(:name, :email, :graduation_year, :password, :password_confirmation)
	end
end
