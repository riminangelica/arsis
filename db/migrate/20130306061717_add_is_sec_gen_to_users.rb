class AddIsSecGenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_sec_gen, :boolean

  end
end
