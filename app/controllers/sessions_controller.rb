class SessionsController < ApplicationController
	layout false
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
			:disposition => "attachment; filename=event_#{@event.id}.csv"
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
		#Setting Page
	    render :layout => "application"
	end

	def changepw
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
			redirect_to(:action => 'profile')


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
