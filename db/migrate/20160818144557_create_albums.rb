class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :image_url
      t.string :title
      t.text :description
      t.string :link
      t.string :type_album
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
