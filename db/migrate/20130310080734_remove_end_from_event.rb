class RemoveEndFromEvent < ActiveRecord::Migration
  def up
  	remove_column :events, :end
  end

  def down
  end
end
