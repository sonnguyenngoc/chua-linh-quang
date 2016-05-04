class CreateSlideshows < ActiveRecord::Migration
  def change
    create_table :slideshows do |t|
      t.string :image_url
      t.string :title_1
      t.string :title_2
      t.string :name_button
      t.string :link

      t.timestamps null: false
    end
  end
end
