class Addcol < ActiveRecord::Migration
  def change
  	add_column :targets , :image, :string
  end
end
