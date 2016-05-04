class CreateParentCategories < ActiveRecord::Migration
  def change
    create_table :parent_categories do |t|
      t.integer :parent_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end