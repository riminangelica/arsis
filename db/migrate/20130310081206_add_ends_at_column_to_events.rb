class AddEndsAtColumnToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :ends_at, :datetime
  end
end
