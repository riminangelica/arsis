class EventsController < ApplicationController
	
	def addevent
		@event = Event.new(params[:event])
		if @event.save
			flash[:notice] = "Event created."
			flash[:color] = "valid"
			redirect_to newevent_path
		else
			message_error=[]
			message_error << "<b>Event could not be created:</b>"
			for x in @event.errors.full_messages
				message_error << "* " + x

				a = message_error.map {|str| "#{str}"}.join("</br>").html_safe
				flash[:notice] = a
				flash[:color] = "invalid"
			end
			redirect_to newevent_path
		end
	end
end