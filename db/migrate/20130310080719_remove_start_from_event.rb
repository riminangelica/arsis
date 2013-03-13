class RemoveStartFromEvent < ActiveRecord::Migration
  def up
  	remove_column :events, :start
  end

  def down
  end
end
