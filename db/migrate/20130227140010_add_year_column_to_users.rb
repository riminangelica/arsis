class AddYearColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :year, :integer

  end
end
