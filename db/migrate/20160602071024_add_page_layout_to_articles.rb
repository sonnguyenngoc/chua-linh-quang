class AddPageLayoutToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :page_layout, :string
  end
end
