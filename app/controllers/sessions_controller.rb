class SessionsController < ApplicationController
	#layout true
  	before_filter :authenticate_user, :except => [ :login, :login_attempt, :logout]
	before_filter :save_login_state, :only => [ :login, :login_attempt]

	# Home Page
	def home
		render :layout => "application"
	end

	# Contact Us Page
	def message
		render :layout => "application"
	end

	# View Profile Page
	def profile
		render :layout => "application"
	end

	# View Event Profile
	def viewevent
		@event = Event.find(params[:event_id])
		render :layout => "application"
	end

	# Track Progress Page
	def progress
		@attendances = Attendance.where(:user_id => @current_user.id)
		@totalpoints = 0

		@attendances.each do |a|
			@totalpoints+= a.points
		end
		render :layout => "application"
	end

	# View Event Calendar Page
	def eventcalendar
		@events = Event.order(:id)
		render :layout => "application"
	end

	def view_dorm_council
		@users = User.where(:utype => "dorm_council")

		render :layout => "application"
	end

	# View Event Calendar Page > Export to CSV Link
	def event_to_csv
		@event = Event.find(params[:id])

		csv_string = CSV.generate() do |csv|
			csv << [@event.id,
					@event.name,
					@event.venue,
					@event.is_open]
		end    

		send_data csv_string,
			:type => 'text/csv; charset=iso-88859-1; header=present',
			:disposition => "attachment; filename=Event_#{@event.id}_#{@event.name}.csv"
	end

	def dormerlist_to_csv
		@users = User.order(:id)
		csv_string = CSV.generate() do |csv|
			@users.each do |user|
			csv << [user.id,
					user.firstname,
					user.middlename,
					user.lastname,
					user.mobile,
					user.email,
					user.year,
					user.course.name,
					user.province,
					user.room,
					user.position,
					user.utype]
			end
		end    
		send_data csv_string,
			:type => 'text/csv; charset=iso-88859-1; header=present',
			:disposition => "attachment; filename=Official List of Resident Students.csv"
	end


	def upload_reg_file
		@attendances = Attendance.all
		render :layout => "application"
	end

	def newevent
		render :layout => "application"
	end

	def viewmembers
		render :layout => "application"
	end

	def setting
		@user = User.find_by_idnum(params[:idnum])
		#Setting Page
	    render :layout => "application"
	end

	def changepw
		@user = User.find(params[:idnum])
		render :layout => "application"
		
	end

	def newevent
		render :layout => "application"
	end

	def login
		#Login Form

	end

	def generatedb
	    @users = User.order(:idnum)
	    render :layout => "application"
	end

	def login_attempt
		authorized_user = User.authenticate(params[:idnum_or_email],params[:login_password])
		if authorized_user
			session[:user_id] = authorized_user.id
			flash[:notice] = "Welcome to ARSIS! You are logged in as #{authorized_user.firstname}"
			redirect_to(:action => 'home')


		else
			flash[:notice] = "Invalid ID Number or Password"
        	flash[:color]= "invalid"
			render "login"	
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to :action => 'login'
	end
end
