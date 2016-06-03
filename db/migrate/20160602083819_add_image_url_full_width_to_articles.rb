class AddImageUrlFullWidthToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :image_url_full_width, :string
  end
end
