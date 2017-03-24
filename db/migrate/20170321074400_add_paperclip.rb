class AddPaperclip < ActiveRecord::Migration
  def change
  	remove_column :targets, :image
  	add_column :targets , :image, :string

  	add_attachment :targets , :image, :string
  end
end
