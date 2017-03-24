class Log1 < ActiveRecord::Migration
  def change
  	create_table :day_logs do |t|
  	  t.integer :target_id
  	  t.string  :date
      t.string  :prev_time
      t.string  :log_hour 
       end   
  end
end
