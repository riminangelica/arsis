class CreateUsers < ActiveRecord::Migration
  	def change
		    create_table(:users, :primary_key => 'idnum') do |t|
		    	t.integer :idnum
		    	t.string  :firstname
		    	t.string  :middlename
		    	t.string  :lastname
		    	t.integer :year
		    	t.string  :course_id
		    	t.string  :province
		    	t.string  :mobile
		    	t.string  :email
		    	t.string  :room
		    	t.string  :encrypted_password 
		    	t.string  :salt
		    	t.string  :security
		    	t.string  :answer
		    	t.attachment :photo

		      	t.timestamps
		    end
	end
end