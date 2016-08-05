class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :image_url
      t.string :title
      t.string :banner_type

      t.timestamps null: false
    end
  end
end
