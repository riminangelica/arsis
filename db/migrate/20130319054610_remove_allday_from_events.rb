class RemoveAlldayFromEvents < ActiveRecord::Migration
  def up
  	remove_column(:events, :allday)
  end

  def down
  end
end
