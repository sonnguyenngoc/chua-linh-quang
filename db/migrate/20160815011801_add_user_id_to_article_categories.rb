class AddUserIdToArticleCategories < ActiveRecord::Migration
  def change
    add_column :article_categories, :user_id, :integer
  end
end
