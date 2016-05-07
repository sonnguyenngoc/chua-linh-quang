class RemoveCodeFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :code, :string
  end
end
