class CreateArticleCategoriesArticles < ActiveRecord::Migration
  def change
    create_table :article_categories_articles do |t|
      t.integer :article_id
      t.integer :article_category_id

      t.timestamps null: false
    end
  end
end
