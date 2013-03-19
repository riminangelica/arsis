class PasswordResetsController < ApplicationController
	def new
	end

	def create
		@user = User.find_by_email(params[:email])

		if @user
			100.times {puts "HELLOOOOOOO AGAIN"}
			redirect_to verify_path(@user.id)
		else
			flash[:notice] = "Invalid e-mail"
			flash[:color] = "invalid"
			redirect_to new_password_reset_path
		end
	end

	def verify

		@user = User.find_by_idnum(params[:id])
		100.times {puts @user.id}
		# 100.times {puts "HELLOOOOOOO AGAINZZ"}
		# @user = User.find(params[:id])
		# 100.times {puts params[:email]}
		# if @user.answer = params[:answer]
		# 	@user.send_password_reset 
		# 	flash[:notice] = "Email sent with password reset instructions."
		# 	flash[:color] = "valid"
		# 	redirect_to :login
		# else
		# 	flash[:notice] = "Fail"
		# 	flash[:color] = "invalid"
		# 	redirect_to new_password_reset_path
		# end
	end

	# def answer
	# 	@answer = params[:answer]
	# 	100.times { puts params[:answer] + "nasdfASDF;KASJDFK"}
	# 	redirect_to{reset_path(params[:email], @answer)}
	# end
	def reset
		100.times {puts params[:id]}
		answer = params[:password_resets][:answer]
		100.times {puts answer}
		@user = User.find_by_id(params[:password_resets][:id])
		100.times {puts params[:answer]}
		if @user
			@user.send_password_reset 
			flash[:notice] = "Email sent with password reset instructions."
			flash[:color] = "valid"
			redirect_to :login
		else
			flash[:notice] = "ERROR! Your answer is incorrect."
			flash[:color] = "invalid"
			redirect_to new_password_reset_path
		end
	end

	def edit
		@user = User.find_by_password_reset_token!(params[:id])
	end

	def update
		@user = User.find_by_password_reset_token!(params[:id])
		if @user.password_reset_sent_at < 2.hours.ago
			flash[:notice] = "Password &crarr; reset has expired."
			flash[:color] = "invalid"
			redirect_to new_password_reset_path
		elsif @user.update_attributes(params[:user])
			flash[:notice] = "Password has been reset."
			flash[:color] = "valid"
			redirect_to :login
		else
			render :edit
		end
	end
end
