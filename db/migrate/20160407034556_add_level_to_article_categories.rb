class AddLevelToArticleCategories < ActiveRecord::Migration
  def change
    add_column :article_categories, :level, :integer
  end
end
