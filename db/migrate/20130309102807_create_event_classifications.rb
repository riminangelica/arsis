class CreateEventClassifications < ActiveRecord::Migration
  def change
    create_table :event_classifications do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end
end
