class Add1 < ActiveRecord::Migration
  def change
  	remove_column :users, :created_at
  	remove_column :users, :updated_at
    add_column    :users, :auth_token, :string
  end
end
