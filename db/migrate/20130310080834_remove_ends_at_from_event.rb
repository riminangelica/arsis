class RemoveEndsAtFromEvent < ActiveRecord::Migration
  def up
  	remove_column :events, :ends_at
  end

  def down
  end
end
