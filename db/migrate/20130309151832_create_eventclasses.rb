class CreateEventclasses < ActiveRecord::Migration
  def change
    create_table :eventclasses do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end
end
