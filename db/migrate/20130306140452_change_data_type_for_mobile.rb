class ChangeDataTypeForMobile < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.change :mobile, :string
    end
  end
 
  def self.down
    change_table :users do |t|
      t.change :mobile, :integer
    end
  end
end
