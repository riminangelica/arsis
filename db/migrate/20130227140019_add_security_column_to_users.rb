class AddSecurityColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :security, :string

  end
end
