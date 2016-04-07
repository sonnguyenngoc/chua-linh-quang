class CreateParentArticleCategories < ActiveRecord::Migration
  def change
    create_table :parent_article_categories do |t|
      t.integer :parent_id
      t.integer :article_category_id

      t.timestamps null: false
    end
  end
end
