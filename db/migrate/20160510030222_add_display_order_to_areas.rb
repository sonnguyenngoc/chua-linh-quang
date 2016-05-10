class AddDisplayOrderToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :display_order, :integer
  end
end
