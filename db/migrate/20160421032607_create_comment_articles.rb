class CreateCommentArticles < ActiveRecord::Migration
  def change
    create_table :comment_articles do |t|
      t.string :name
      t.string :email
      t.text :content
      t.integer :user_id
      t.integer :article_id

      t.timestamps null: false
    end
  end
end
