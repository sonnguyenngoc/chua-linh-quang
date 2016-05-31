class AddIsShowToProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_show, :boolean, default: false
  end
end
