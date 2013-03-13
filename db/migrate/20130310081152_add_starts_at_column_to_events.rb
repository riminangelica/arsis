class AddStartsAtColumnToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :starts_at, :datetime
  end
end
