class AddAreaIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :area_id, :integer
  end
end
