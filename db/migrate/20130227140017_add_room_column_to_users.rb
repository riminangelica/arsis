class AddRoomColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :room, :string

  end
end
