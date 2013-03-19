class VerifyresetController < ApplicationController
	def new
	end

	def create
		user = User.find_by_answer(params[:answer])
		if user
			user.send_password_reset 
			flash[:notice] = "Success! Email sent with password reset instructions."
			flash[:color] = "valid"
			redirect_to :login
		else
			flash[:notice] = "ERROR! Your answer is incorrect."
			flash[:color] = "invalid"
			redirect_to new_password_reset_path
		end
	end
end
