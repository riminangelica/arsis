class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :id
      t.integer :eventclass_id
      t.string :name
      t.datetime :start
      t.datetime :end
      t.boolean :allday
      t.string :venue
      t.boolean :is_open

      t.timestamps
    end
  end
end
