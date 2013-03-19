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
    security = params[:user][:security]
    # Validates authorization code entered by Secretary General

    if @user == nil
      flash[:notice] = "Invalid ID Number: You cannot sign up as a dormer."
      flash[:color] = "invalid"
      @user = User.new(params[:user])
    else
      if auth_code
        @user.utype = 'sec_gen'
        
        if !security.blank?
          if @user.update_attributes(params[:user])
            flash[:notice] = "Your account has been activated as Secretary General"
            flash[:color] = "valid"

          #redirect_to signup_path
        else
          flash[:notice] = "Form is invalid. Please check below for errors."
          flash[:color]= "invalid"
        end
      else
        flash[:notice] = "You already have an existing account."
        flash[:color]= "invalid"
      end
    else
      if !security.blank?
        if @user.update_attributes(params[:user])
          if @user.utype == 'dormer'
            flash[:notice] = "Your account has been activated as a dormer"
            flash[:color]= "valid"
          elsif @user.utype == 'dorm_council'
            flash[:notice] = "Your account has been activated as a member of the dorm council"
            flash[:color]= "valid"
          end
          #redirect_to signup_path
        else
          flash[:notice] = "Form is invalid. Please check below for errors."
          flash[:color]= "invalid"
        end
      else
        flash[:notice] = "You already have an existing account."
        flash[:color]= "invalid"
      end
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
    flash[:notice] = "Profile Updated"
    flash[:color] = "valid"
    redirect_to setting_path(@user.idnum)
  else 
    100.times { puts @user.id }
    message_error=[]

    if @user.errors.any?
      message_error << "<b>Profile not updated:</b>"
      for x in @user.errors.full_messages
        puts message_error
        message_error << "* " + x

        a = message_error.map {|str| "#{str}"}.join("</br>").html_safe
        flash[:notice] = a
        flash[:color] = "invalid"
      end
    end
    redirect_to setting_path(@user.idnum)
  end
end

def change_password
  @user = User.find_by_idnum(params[:idnum])
  100.times { puts @user.idnum }
  100.times { puts "HELLODUUUURRRR"}
    #@user.update_attribute(:password_confirmation, params[:password_confirmation])
    #if @user.update_attribute(:password, params[:password]) 
    if @user.update_attributes(params[:user])
      flash[:notice] = "Password Updated"
      flash[:color] = "valid"
      redirect_to changepw_path(@user.idnum)
    else 
      message_error=[]
      
      if @user.errors.any?
        message_error << "<b>Password not updated:</b>"
        for x in @user.errors.full_messages
          puts message_error
          message_error << "* " + x
          
          a = message_error.map {|str| "#{str}"}.join("</br>").html_safe
          flash[:notice] = a
          flash[:color] = "invalid"
        end
      end
      redirect_to changepw_path(@user.idnum)
    end
  end 

  # Generate Dormer Database Page
  # Imports CSV File to the database
  def import
    User.import(params[:file])
    flash[:notice] = "Dormers imported."
    flash[:color] = "valid"


    redirect_to generatedb_path
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

  # SOA - Search User via ID Number
  def id
    @user = User.find_by_id(params[:id])

    respond_to do |format|
      if @user!=nil
        format.html { render json: {:message => "Here are #{@user.firstname} #{@user.lastname}'s details.", :user => @user}}
      else
        format.html { render json: {:message => "Cannot find user - that ID number does not exist. Please enter a valid ID number."}}
      end
    end
  end

  # SOA - Search Users via First Name
  def firstname
    @users = User.where(:firstname => params[:firstname])
    
    respond_to do |format|
      if @users.size>0
        format.html { render json: {:message => "Here are the details of #{@users.size} user(s) named #{params[:firstname]}.", :users => @users}}
      elsif @users.size<=0
        format.html { render json: {:message => "Cannot find user - that name does not exist. Please enter a valid first name."}}
      end
    end
  end

  # SOA - Search Users via Last Name
  def lastname
    @users = User.where(:lastname => params[:lastname])
    
    respond_to do |format|
      if @users.size>0
        format.html { render json: {:message => "Here are the details of #{@users.size} user(s) with the surname #{params[:lastname]}.", :users => @users}}
      elsif @users.size<=0
        format.html { render json: {:message => "Cannot find user - that name does not exist. Please enter a valid last name."}}
      end
    end
  end

  # SOA - Search Users via First Name and Last Name
  def firstname_lastname
    a = User.where(:firstname => params[:firstname], :lastname => params[:lastname])
    
    respond_to do |format|
      if a.size>0
        format.html { render json: {:message => "Here is the user you're looking for!", :user => a}}
      else
        format.html { render json: {:message => "We don't have that user. Sorry."}}
      end
    end
  end

  # SOA - Search Users under given Course ID
  def course
    u = User.find_all_by_course_id(params[:course_id])
    @course = Course.find_by_id(params[:course_id])
    @users=[]

    for x in u do
      @users<<User.find_by_id(x.id)
    end 
    
    respond_to do |format|
      if @users.size>0
        format.html { render json: { :message => "Here are the details of #{@users.size} student(s) studying #{@course.name}", :course_id => @course, :users => @users}}
      elsif @users.size<=0 && @course!=nil
        format.html { render json: {:message => "There are no users studying #{@course.name}."}}   
      else
        format.html { render json: {:message => "Unauthorized Access: Course ID given does not exist."}}
      end
    end
  end

  # SOA - Search Users under given Year Level
  def yr
    @users = User.where(:year => params[:year])
    
    respond_to do |format|
      if @users.size>0
        format.html { render json: {:message => "Here are the details of #{@users.size} student(s) under Year #{params[:year]}", :users => @users}}
      elsif @users.size<=0
        format.html { render json: {:message => "There are no users under that year level."}}
      end
    end
  end
end
