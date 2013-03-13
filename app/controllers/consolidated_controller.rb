class ConsolidatedController < ApplicationController
	before_filter :authenticate_user
	#before_filter :save_login_state, :only => [ :login, :login_attempt]

	def index
		@users = User.all

		render :layout => "application"
	end

end