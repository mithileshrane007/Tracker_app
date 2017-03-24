class Addcol2 < ActiveRecord::Migration
  def change
  	add_column :checkouts, :latitude, :decimal, {:precision=>10, :scale=>6}
	add_column :checkouts, :longitude, :decimal, {:precision=>10, :scale=>6}
  end
end
