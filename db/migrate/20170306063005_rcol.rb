class Rcol < ActiveRecord::Migration
  def change
  	remove_column :logs, :updated_at
  end
end
