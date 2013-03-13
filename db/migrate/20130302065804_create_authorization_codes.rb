class CreateAuthorizationCodes < ActiveRecord::Migration
  def change
    create_table :authorization_codes do |t|
      t.integer :id
      t.string :code

      t.timestamps
    end
  end
end
