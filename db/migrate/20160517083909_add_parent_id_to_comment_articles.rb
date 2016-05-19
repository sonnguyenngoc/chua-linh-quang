class AddParentIdToCommentArticles < ActiveRecord::Migration
  def change
    add_column :comment_articles, :parent_id, :integer, default: -1
  end
end
