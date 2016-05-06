class AddStyleToSlideshows < ActiveRecord::Migration
  def change
    add_column :slideshows, :style, :string
  end
end
