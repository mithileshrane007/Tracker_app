class Log < ActiveRecord::Migration
  def change
  	remove_column :users , :is_verified, :boolean,:default => false
  	add_column :users , :is_verified, :boolean,:default => true
  end
end
