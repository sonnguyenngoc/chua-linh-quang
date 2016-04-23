class AddColor1AndColor2ToSlideshows < ActiveRecord::Migration
  def change
    add_column :slideshows, :color_1, :string
    add_column :slideshows, :color_2, :string
  end
end
