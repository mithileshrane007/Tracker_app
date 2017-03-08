class Addrows < ActiveRecord::Migration
  def change
  	 add_column    :targets, :track_time_interval, :string
  	 add_column    :targets, :track_time_out, :string
  end
end
