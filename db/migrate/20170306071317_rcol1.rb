class Rcol1 < ActiveRecord::Migration
  def change
  	remove_column :checkouts, :updated_at
  end
end
