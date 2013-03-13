class AddMiddlenameToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :middlename, :string
  end
end
