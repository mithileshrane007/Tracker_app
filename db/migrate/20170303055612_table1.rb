class Table1 < ActiveRecord::Migration
  def change
  	create_table :logs do |t|
      t.string :created_at
      t.integer :target_id
      
      t.timestamps null: false
    end
  end
end