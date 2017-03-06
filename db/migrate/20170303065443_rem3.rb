class Rem3 < ActiveRecord::Migration
  def change
  	remove_column :targets, :phone_no
  	add_column :targets , :phone_no, :integer , :limit => 8
  end
end
