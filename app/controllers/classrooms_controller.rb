class ClassroomsController < ApplicationController
	before_action :set_classroom, only: [:show, :edit, :update, :destroy]

	# GET /classrooms
	# GET /classrooms.json
	def index
		@classrooms = Classroom.all
	end

	# GET /classrooms/1
	# GET /classrooms/1.json
	def show
	end

	# GET /classrooms/new
	def new
		@classroom = Classroom.new
	end

	# GET /classrooms/1/edit
	def edit
	end

	# POST /classrooms
	# POST /classrooms.json
	def create
		@classroom = Classroom.new(classroom_params)

		respond_to do |format|
			if @classroom.save
				format.html { redirect_to @classroom, notice: 'Classroom was successfully created.' }
				format.json { render action: 'show', status: :created, location: @classroom }
			else
				format.html { render action: 'new' }
				format.json { render json: @classroom.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /classrooms/1
	# PATCH/PUT /classrooms/1.json
	def update
		respond_to do |format|
			if @classroom.update(classroom_params)
				format.html { redirect_to @classroom, notice: 'Classroom was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @classroom.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /classrooms/1
	# DELETE /classrooms/1.json
	def destroy
		@classroom.destroy
		respond_to do |format|
			format.html { redirect_to classrooms_url }
			format.json { head :no_content }
		end
	end

	# GET /classrooms/1/join
	# I know, kinda hacky
	def join
		@classroom = Classroom.find(params[:id])

		params[:user_id] = current_user.id unless admin? && params[:user_id]

		@membership = Membership.new
		@membership.classroom_id = @classroom.id
		@membership.user_id = params[:user_id]
		if @membership.save
			redirect_to @classroom, notice: "Joined!"
		else
			redirect_to @classroom, alert: "You are already a member of this class!"
		end
	end

	# GET /classrooms/1/leave
	def leave
		@classroom = Classroom.find(params[:id])

		params[:user_id] = current_user.id unless admin? && params[:user_id]

		@membership = Membership.where("user_id = ? AND classroom_id = ?", params[:user_id], @classroom.id).first
		if @membership.destroy
			redirect_to @classroom, notice: "Left!"
		else
			redirect_to root_path, alert: "WTF did you just try to do."
		end
	end


	private
	# Use callbacks to share common setup or constraints between actions.
	def set_classroom
		@classroom = Classroom.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def classroom_params
		params.require(:classroom).permit(:course_id, :teacher_id, :description, :period, :course_name, :teacher_name)
	end
end
