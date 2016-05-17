class AddMetaKeywordsAndMetaDescriptionToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :meta_keywords, :string
    add_column :categories, :meta_description, :text
  end
end
