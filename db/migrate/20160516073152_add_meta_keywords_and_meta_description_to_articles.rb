class AddMetaKeywordsAndMetaDescriptionToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :meta_keywords, :string
    add_column :articles, :meta_description, :text
  end
end
