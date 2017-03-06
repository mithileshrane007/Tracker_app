class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.integer :target_id
      t.text :description
      t.string :created_at

      t.timestamps null: false
    end
  end
end
