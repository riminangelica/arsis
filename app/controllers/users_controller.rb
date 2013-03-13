class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]
  before_filter :check_for_cancel, :only => [:create, :update]

  def new
      #Signup Form
      @user = User.new     
  end

  def create
    @user = User.find_by_idnum(params[:user][:idnum])
    auth_code = AuthorizationCode.find_by_code(params[:authorization_code])
    # Validates authorization code entered by Secretary General

    if @user == nil
      flash[:notice] = "Invalid ID Number: You cannot sign up as a dormer."
      flash[:color] = "invalid"
      @user = User.new(params[:user])
    else
      if auth_code
        @user.utype = 'sec_gen'
        flash[:notice] = "You have signed up as a Secretary General"
        flash[:color] = "valid"
      else
        @user.utype = 'dormer'
        flash[:notice] = "You cannot sign up as a Secretary General"
        flash[:color] = "invalid"
      end
      if @user.update_attributes(params[:user])
        flash[:notice] = "You signed up successfully"
        flash[:color]= "valid"

        #redirect_to signup_path
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
      end
    end
    render "new"
  end

  def check_for_cancel
    if params[:commit] == "Cancel"
      redirect_to login_path
    end
  end

  def edit
    @user = User.find_by_idnum(params[:user][:idnum])
    if @user.update_attributes(params[:user])
      redirect_to setting_path
      flash[:notice] = "Profile Updated"
      flash[:color] = "valid"
    else 
      flash[:notice] = "Fail"
    end
  end

  def change_password 
    @user = User.find_by_idnum(params[:user][:idnum])
    if @user.update_attributes(params[:user])
      redirect_to changepw_path
      flash[:notice] = "Password Updated"
      flash[:color] = "valid"
    else 
      flash[:notice] = "Fail"
    end
  end 

  # Generate Dormer Database Page
  # Imports CSV File to the database
  def import
    User.import(params[:file])
    redirect_to generatedb_path
    flash[:notice] = "Users imported."
    flash[:color] = "valid"
  end

  # Generate Dormer Database Page
  # Exports dormer database to an excel file
  def index
    @users = User.order(:idnum)
    respond_to do |format|
      format.html
      #format.csv { send_data @users.to_csv }
      format.xls
    end
  end

  # Generate Dormer Database Page
  # Deletes user
  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to generatedb_path
        flash[:notice] = "User deleted."
        flash[:color] = "valid" }
      format.json { head :no_content }
    end
  end
end
