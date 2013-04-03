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

	def id
		@event = Event.find_by_id(params[:id])

		respond_to do |format|
			if @event!=nil
				format.html { render json: {:message => "Here are #{@event.name}'s details.", :event => @event}}
			else
				format.html { render json: {:message => "Cannot find event - that ID number does not exist. Please enter a valid ID number."}}
			end
		end
	end

	def name
		@event = Event.find_by_name(params[:name])

		respond_to do |format|
			if @event!=nil
				format.html { render json: {:message => "Here are #{@event.name}'s details.", :event => @event}}
			else
				format.html { render json: {:message => "Cannot find event - that ID number does not exist. Please enter a valid ID number."}}
			end
		end
	end

  # SOA - Search Events via Name
  def venue
  	@events = Event.where(:venue => params[:venue])

  	respond_to do |format|
  		if @events.size>0
  			format.html { render json: {:message => "Here are the details of #{@events.size} event(s) happening in #{params[:venue]}.", :events => @events}}
  		elsif @events.size<=0
  			format.html { render json: {:message => "Cannot find event - that venue does not exist. Please enter a valid venue."}}
  		end
  	end
  end

  def eventclass
  	u = Event.find_all_by_eventclass_id(params[:eventclass_id])
  	@eventclass = Eventclass.find_by_id(params[:eventclass_id])
  	@events=[]

  	for x in u do
  		@events<<Event.find_by_id(x.id)
  	end 

  	respond_to do |format|
  		if @events.size>0
  			format.html { render json: { :message => "Here are the details of #{@events.size} event(s) under the #{@eventclass.name} Classification", :eventclass_id => @eventclass, :events => @events}}
  		elsif @events.size<=0 && @eventclass!=nil
  			format.html { render json: {:message => "There are no events under #{@eventclass.name}."}}   
  		else
  			format.html { render json: {:message => "Unauthorized Access: eventclass ID given does not exist."}}
  		end
  	end
  end
end