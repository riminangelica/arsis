class ChangeEndsAtDataType < ActiveRecord::Migration
  def up
  	change_column :events, :ends_at, :date
  end

  def down
  end
end
