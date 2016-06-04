class CreateAreasArticles < ActiveRecord::Migration
  def change
    create_table :areas_articles do |t|
      t.integer :area_id
      t.integer :article_id
      
      t.timestamps null: false
    end
  end
end
