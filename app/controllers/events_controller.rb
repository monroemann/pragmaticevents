class EventsController < ApplicationController
	before_action :require_signin, except: [:index, :show]
	before_action :require_admin, except: [:index, :show]
	before_action :set_event, only: [:show, :edit, :update, :destroy]

	def index
		case params[:scope]
		when "past"
			@events = Event.past
		when "free"
			@events = Event.free
		when "recent"
			@events = Event.recent
		else			
			@events = Event.upcoming
		end
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
		@likers = @event.likers
		if current_user
			@current_like = current_user.likes.find_by(event_id: @event.id)
		end
		@categories = @event.categories
	end

	def edit
	end

	def update
		if @event.update(event_params)
			# flash[:notice] = "Event Updated!"
			redirect_to @event, notice: "Event Updated!"
		else
			render :new
		end
 	end

 	def destroy
 		@event.destroy
 		redirect_to events_url
 	end

 	private

 	def event_params
 		params.require(:event).permit(:name, :description, :price, :location, :starts_at, :image_file_name, :capacity, category_ids: [] )
 	end

 	def set_event
 		@event = Event.find_by!(slug: params[:id])
 	end

end
