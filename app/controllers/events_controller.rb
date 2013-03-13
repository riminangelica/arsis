class EventsController < ApplicationController
	
	def addevent
		@event = Event.new(params[:event])
		if @event.save
			redirect_to newevent_path
			flash[:notice] = "Event created."
			flash[:color] = "valid"
		else
			redirect_to newevent_path
			flash[:notice] = "Failed to create event."
			flash[:color] = "valid"
		end
	end
	
end