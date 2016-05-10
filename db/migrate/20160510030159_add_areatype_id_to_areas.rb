class AddAreatypeIdToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :areatype_id, :integer
  end
end
