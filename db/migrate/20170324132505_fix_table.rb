class FixTable < ActiveRecord::Migration
  def change
  		add_column :day_logs , :start_time, :time
  		add_column :day_logs, :time_zone, :string
  		rename_column :day_logs, :prev_time, :end_time
  		change_column :day_logs, :end_time, :time  	
		change_column :day_logs, :log_hour, :time
		change_column :day_logs, :date, :date
  end
end
