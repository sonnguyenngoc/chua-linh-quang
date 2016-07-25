class AddImageUrlToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :image_url, :string
  end
end
