class RemoveAreaIdFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :area_id, :integer
  end
end
