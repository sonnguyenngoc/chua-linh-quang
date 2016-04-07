class AddIsMainToProductImages < ActiveRecord::Migration
  def change
    add_column :product_images, :is_main, :string, default: "False"
  end
end
