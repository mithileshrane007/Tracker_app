class Online < ActiveRecord::Migration
  def change
  	add_column :targets , :is_online, :boolean,:default => false
  end
end
