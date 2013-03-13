class AddIdnumColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :idnum, :integer

  end
end
