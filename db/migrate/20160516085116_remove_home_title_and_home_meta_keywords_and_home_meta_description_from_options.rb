class RemoveHomeTitleAndHomeMetaKeywordsAndHomeMetaDescriptionFromOptions < ActiveRecord::Migration
  def change
    remove_column :options, :home_title, :string
    remove_column :options, :home_meta_keywords, :string
    remove_column :options, :home_meta_description, :text
  end
end
