class AddParentIdToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :parent_id, :integer
  end
end
