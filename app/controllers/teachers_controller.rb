class TeachersController < ApplicationController
	load_and_authorize_resource
	before_action :set_teacher, only: [:show, :edit, :update, :destroy]

	# GET /teachers
	# GET /teachers.json
	def index
		if params[:q]
			@teachers = Teacher.where("LOWER(name) LIKE LOWER(?)", "%" + params[:q] + "%")
		else
			@teachers = Teacher.all
		end
		respond_to do |format|
			format.html
			format.json { render json: @teachers.map { |c| c.name } }
		end
	end

	# GET /teachers/1
	# GET /teachers/1.json
	def show
	end

	# GET /teachers/new
	def new
		@teacher = Teacher.new
	end

	# GET /teachers/1/edit
	def edit
	end

	# POST /teachers
	# POST /teachers.json
	def create
		@teacher = Teacher.new(teacher_params)

		respond_to do |format|
			if @teacher.save
				format.html { redirect_to @teacher, notice: "Teacher was successfully created." }
				format.json { render action: "show", status: :created, location: @teacher }
			else
				format.html { render action: "new" }
				format.json { render json: @teacher.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /teachers/1
	# PATCH/PUT /teachers/1.json
	def update
		respond_to do |format|
			if @teacher.update(teacher_params)
				format.html { redirect_to @teacher, notice: "Teacher was successfully updated." }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @teacher.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /teachers/1
	# DELETE /teachers/1.json
	def destroy
		@teacher.destroy
		respond_to do |format|
			format.html { redirect_to teachers_url }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_teacher
		@teacher = Teacher.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def teacher_params
		params.require(:teacher).permit(:name, :email)
	end
end
