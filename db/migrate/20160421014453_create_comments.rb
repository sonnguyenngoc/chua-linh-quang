class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :product_id
      t.string :name
      t.text :content
      t.integer :star
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
