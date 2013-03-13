class RemoveTimeFromEvent < ActiveRecord::Migration
  def up
    remove_column :events, :time
  end

  def down
    #add_column :users, :username, :string
  end
end
