class ChangeStartsAtAndEndsAtDataTypes < ActiveRecord::Migration
  def up
  	change_column :events, :starts_at, :datetime
  	change_column :events, :ends_at, :datetime
  	add_column :events, :user_id, :integer
  end

  def down
  end
end
