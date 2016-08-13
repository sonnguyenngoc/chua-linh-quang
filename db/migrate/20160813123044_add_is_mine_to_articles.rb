class AddIsMineToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_mine, :boolean, default: false
  end
end
