class Addauth < ActiveRecord::Migration
  def change
  	add_column    :targets, :auth_token, :string
  end
end
