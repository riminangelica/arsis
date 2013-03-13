class FixDate < ActiveRecord::Migration
  def up
  	rename_column :events, :date, :start
  end

  def down
  end
end
