class Rem1 < ActiveRecord::Migration
  def change
  	add_column    :logs, :time_zone, :string
  end
end
