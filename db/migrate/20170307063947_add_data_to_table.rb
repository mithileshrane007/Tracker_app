class AddDataToTable < ActiveRecord::Migration
  def change
  	add_attachment :targets, :image
  end
end
