class User < ActiveRecord::Base

	attr_accessor :password

	before_save :encrypt_password
	after_save :clear_password

	belongs_to :course
	has_many :attendances
	has_many :events, :through => :attendances
	belongs_to :role

	# has_attached_file :image, :style => { :small => "150x150#", :large => "500x500>" },
	# :url => "/assets/images/users/:id/:style/:basename.:extension",
	# :path => ":rails_root/public/assets/images/users/:id/:style/:basename.:extension",
	# default_url: "assets/attachment/missing_:style.png"

	has_attached_file :image
    # add a delete_<asset_name> method: 
    attr_accessor :delete_image
    before_validation { self.image.clear if self.delete_image == '1' }

	# validates_attachment_presence :image
	# validates_attachment_size :image, :less_than => 700.kilobytes
	# validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']	

	EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i
	# NAME_REGEX = /^[0-9!@#$%]{2,4}$/i
	# ID Number
	validates :idnum, :presence => true, :uniqueness => true, :length => { :is => 6 }, :numericality => true;
	# First Name
	validates :firstname, :presence => true, :length => { :in => 2..45 }
	# Middle Name
	validates :middlename, :presence => true, :length => { :in => 2..45 }
	# Last Name
	validates :lastname, :presence => true, :length => { :in => 2..45 }
	# Year
	validates :year, :presence => true, :length => { :is => 1 }, :numericality => { :less_than_or_equal_to => 5 }
	# Course
	validates :course_id, :presence => true
	# Province of Origin
	validates :province, :presence => true, :length => { :in => 2..45 }
	# Mobile Number
	validates :mobile, :presence => true, :uniqueness => true, :length => { :in => 9..11 }
	# Email
	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
	# Room Number
	validates :room, :presence => true, :length => { :in => 3..7 }
	# Password Confirmation
	validates :password, :confirmation => true #password_confirmation attr
	# Only on Create so other actions like update password attribute can be nil
	# Password
	validates :password, :length => {:in => 6..20 }, :presence => :true
	# Security Question
	validates :security, :presence => true, :length => { :in => 2..80 }
	# Answer
	validates :answer, :presence => true, :length => { :in => 2..45 }

	# Adds accessible attributes to user model
	attr_accessible :idnum, :firstname, :middlename, :lastname, :year, :course_id, :province, :mobile, :email, :room, :password, :password_confirmation, :security, :answer, :is_sec_gen, :image, :position, :utype

	# take a username/email and password to find out if that matches a user in the database
	# Needs a query to match username/email and, 
	# if found, encrypt the entered password and compare it with the encrypted password in the database.

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def self.authenticate(idnum_or_email="", login_password="")

		if  EMAIL_REGEX.match(idnum_or_email)    
			user = User.find_by_email(idnum_or_email)
		else
			user = User.find_by_idnum(idnum_or_email)
		end

		if user && user.match_password(login_password)
			return user
		else
			return false
		end
	end   

	def match_password(login_password="")
		encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
	end

  	# We need two functions: 
  	# (1) to encrypt the actual password (plain text) before saving the user record, and 
  	def encrypt_password
  		unless password.blank?
    		# Encrypt password using BCrypt
    		self.salt = BCrypt::Engine.generate_salt
    		self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    	end
    end

  	# (2) to assign the password attr_accessor to nil
  	def clear_password
  		self.password = nil
  	end

  	def password_present?
  		!password.nil?
  	end

  	def encrypt_answer
  		unless answer.blank?
    		# Encrypt answer using BCrypt
    		self.salt = BCrypt::Engine.generate_salt
    		self.encrypted_answer = BCrypt::Engine.hash_secret(answer, salt)
    	end
    end

  	# (2) to assign the password attr_accessor to nil
  	def clear_answer
  		self.answer = nil
  	end

  	#def self.import(file)
	#  CSV.foreach(file.path, headers: true) do |row|
	#    User.create! row.to_hash, :validate => false
	#  end
	#end

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			user = find_by_id(row["id"]) || new
			user.attributes = row.to_hash.slice(*accessible_attributes)
			user.save! :validate => false
		end
	end

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |user|
				csv << user.attributes.values_at(*column_names)
			end
		end    
	end

	def totalpoints
		x = 0

		attendances = Attendance.where(:user_id => id)

		attendances.each do |a|
			x += a.points
		end

		return x
	end

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save! :validate => false
		UserMailer.password_reset(self).deliver
	end


end