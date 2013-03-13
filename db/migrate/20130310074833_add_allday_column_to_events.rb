class AddAlldayColumnToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :allday, :boolean
  end
end
