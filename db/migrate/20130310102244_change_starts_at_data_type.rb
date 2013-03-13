class ChangeStartsAtDataType < ActiveRecord::Migration
  def up
  	change_column :events, :starts_at, :date
  end

  def down
  end
end
