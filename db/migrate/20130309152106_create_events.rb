class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :id
      t.integer :eventclass_id
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :venue
      t.boolean :is_open

      t.timestamps
    end
  end
end
