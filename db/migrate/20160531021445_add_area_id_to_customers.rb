class AddAreaIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :area_id, :integer
  end
end
