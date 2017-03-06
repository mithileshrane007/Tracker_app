class Rem2 < ActiveRecord::Migration
  def change
  	remove_column :users, :phone_no
  	add_column :users , :phone_no, :integer , :limit => 8
  end
end
