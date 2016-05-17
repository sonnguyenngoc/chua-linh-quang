class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :home_title
      t.string :home_meta_keywords
      t.text :home_meta_description

      t.timestamps null: false
    end
  end
end
