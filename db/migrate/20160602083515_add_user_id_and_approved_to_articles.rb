class AddUserIdAndApprovedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :user_id, :integer
    add_column :articles, :approved, :boolean, default: false
  end
end
