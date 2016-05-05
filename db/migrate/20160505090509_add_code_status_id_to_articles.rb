class AddCodeStatusIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :code_status_id, :integer
  end
end
