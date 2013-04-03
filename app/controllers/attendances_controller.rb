class AttendancesController < ApplicationController
  # Generate Dormer Database Page
  # Imports CSV File to the database
  def import
  	Attendance.import(params[:file])
  	flash[:notice] = "Attendances imported."
  	flash[:color] = "valid"
  	redirect_to regfile_path
  end

  def create
  	@attendance = Attendance.new
  	@event = Event.find_by_id(params[:event_id])
  	@user = User.find_by_id(params[:user_id])
  	pts = params[:points]
  	100.times {puts "HIIII" + pts}
	
  	respond_to do |format|
  		# if pts == 1
  		if @event && @user && @attendance.save!
  			format.html { render json: {:message => "#{@user.firstname} #{@user.lastname} successfully attended the #{@event.name} as a participant for #{@attendance.points} points.", :user => @user, :event => @event, :attendance => @attendance}}
  		elsif !@event && @user
  			format.html { render json: {:message => "Unable to attend event - that event ID does not exist."}}
  		elsif @event && !@user
  			format.html { render json: {:message => "Unable to attend event - that user ID does not exist."}}
  		elsif !@event && !@user
  			format.html { render json: {:message => "Unable to attend event - event ID and user ID does not exist."}}
  		end
  		# elsif pts == 2
  		# 	if @event && @user
  		# 		attendance.points = 2
  		# 		attendance.role = "Volunteer"
  		# 		format.html { render json: {:message => "#{@user.firstname} #{@user.lastname} successfully attended the #{@event.name} as a volunteer for #{@attendance.points} points.", :user => @user, :event => @event, :attendance => @attendance}}
  		# 	elsif !@event && @user
  		# 		format.html { render json: {:message => "Unable to attend event - that event ID does not exist."}}
  		# 	elsif @event && !@user
  		# 		format.html { render json: {:message => "Unable to attend event - that user ID does not exist."}}
  		# 	elsif !@event && !@user
  		# 		format.html { render json: {:message => "Unable to attend event - event ID and user ID does not exist."}}
  		# 	end
  		# # elsif pts == 3
  		# 	if @event && @user
  		# 		attendance.points = 3
  		# 		attendance.role = "Core"
  		# 		format.html { render json: {:message => "#{@user.firstname} #{@user.lastname} successfully attended the #{@event.name} as a core member for #{@attendance.points} points.", :user => @user, :event => @event, :attendance => @attendance}}
  		# 	elsif !@event && @user
  		# 		format.html { render json: {:message => "Unable to attend event - that event ID does not exist."}}
  		# 	elsif @event && !@user
  		# 		format.html { render json: {:message => "Unable to attend event - that user ID does not exist."}}
  		# 	elsif !@event && !@user
  		# 		format.html { render json: {:message => "Unable to attend event - event ID and user ID does not exist."}}
  		# 	end
  		# else
  			# format.html { render json: {:message => "Unable to attend event - please enter the correct points to be"}}
  		# end
  	end

  end
end
