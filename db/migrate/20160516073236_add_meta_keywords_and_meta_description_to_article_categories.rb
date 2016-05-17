class AddMetaKeywordsAndMetaDescriptionToArticleCategories < ActiveRecord::Migration
  def change
    add_column :article_categories, :meta_keywords, :string
    add_column :article_categories, :meta_description, :text
  end
end
