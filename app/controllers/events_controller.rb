class EventsController < ApplicationController
	load_and_authorize_resource
	before_action :set_event, only: [:show, :edit, :update, :destroy]

	# GET /events
	# GET /events.json
	def index
		@events = Event.all
	end

	# GET /events/1
	# GET /events/1.json
	def show
	end

	# GET /events/new
	def new
		@event = Event.new
	end

	# GET /events/1/edit
	def edit
	end

	# POST /events
	# POST /events.json
	def create
		@event = Event.new(event_params)

		respond_to do |format|
			if @event.save
				format.html { redirect_to @event, notice: "Event was successfully created." }
				format.json { render action: "show", status: :created, location: @event }
			else
				format.html { render action: "new" }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /events/1
	# PATCH/PUT /events/1.json
	def update
		respond_to do |format|
			if @event.update(event_params)
				format.html { redirect_to @event, notice: "Event was successfully updated." }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /events/1
	# DELETE /events/1.json
	def destroy
		@event.destroy
		respond_to do |format|
			format.html { redirect_to events_url }
			format.json { head :no_content }
		end
	end

	# GET /events/1/join
	# Copied from classroom controller
	def join
		@event = Event.find(params[:id])

		params[:user_id] = current_user.id unless admin? && params[:user_id]

		@attendance = Attendance.new
		@attendance.event_id = @event.id
		@attendance.user_id = params[:user_id]
		if @attendance.save
			redirect_to @event, notice: "Joined!"
		else
			redirect_to root_path, alert: "WTF did you just try to do."
		end
	end

	# GET /events/1/leave
	def leave
		@event = Event.find(params[:id])

		params[:user_id] = current_user.id unless admin? && params[:user_id]

		@attendance = Attendance.where("user_id = ? AND event_id = ?", params[:user_id], @event.id).first
		if @attendance.destroy
			redirect_to @event, notice: "Left!"
		else
			redirect_to root_path, alert: "WTF did you just try to do."
		end
	end


	private
	# Use callbacks to share common setup or constraints between actions.
	def set_event
		@event = Event.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def event_params
		params.require(:event).permit(:name, :description, :date)
	end
end
