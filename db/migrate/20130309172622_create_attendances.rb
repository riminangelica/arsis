class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :event_id
      t.integer :user_idnum
      t.integer :points

      t.timestamps
    end
  end
end
