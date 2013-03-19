class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :event_id
      t.integer :user_id
      t.integer :points
      t.string :role

      t.timestamps
    end
  end
end
