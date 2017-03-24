class Addemail < ActiveRecord::Migration
  def change
  	add_column :targets , :email, :string
  end
end
