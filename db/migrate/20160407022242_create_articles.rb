class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :image_url
      t.string :title
      t.text :content
      t.string :tags
      t.integer :article_category_id

      t.timestamps null: false
    end
  end
end
