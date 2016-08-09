class AddStyleToArticleCategories < ActiveRecord::Migration
  def change
    add_column :article_categories, :style, :string
  end
end
