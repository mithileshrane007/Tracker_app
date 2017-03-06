class Addcol1 < ActiveRecord::Migration
  def change
  	add_column :logs, :latitude, :decimal, {:precision=>10, :scale=>6}
	add_column :logs, :longitude, :decimal, {:precision=>10, :scale=>6}
  end
end
