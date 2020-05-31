class EventsController < ApplicationController

	def index
		@events = Event.upcoming
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			redirect_to @event
		else
			render :new
		end
	end

	def show
		@event = Event.find(params[:id])
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		if @event.update(event_params)
			# flash[:notice] = "Event Updated!"
			redirect_to @event, notice: "Event Updated!"
		else
			render :new
		end
 	end

 	def destroy
 		@event = Event.find(params[:id])
 		@event.destroy
 		redirect_to events_url
 	end

 	private

 	def event_params
 		params.require(:event).permit(:name, :description, :price, :location, :starts_at, :image_file_name, :capacity)
 	end


end
