class AddMetaKeywordsAndMetaDescriptionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :meta_keywords, :string
    add_column :products, :meta_description, :text
  end
end
