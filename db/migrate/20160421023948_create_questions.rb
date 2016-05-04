class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.string :email
      t.text :content
      t.integer :product_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
