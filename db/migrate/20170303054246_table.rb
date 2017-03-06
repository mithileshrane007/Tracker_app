class Table < ActiveRecord::Migration
  def change
  	create_table :targets do |t|
      t.string :first_name
      t.string :last_name
      t.string :tracking_id
      t.integer :phone_no
      t.integer :user_id
      
      t.timestamps null: false
    end
  end
end
 
