class CreateArticlesProducts < ActiveRecord::Migration
  def change
    create_table :articles_products do |t|
      t.integer :article_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
