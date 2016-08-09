class AddPositionToArticleCategories < ActiveRecord::Migration
  def change
    add_column :article_categories, :position, :integer, default: 1
  end
end
