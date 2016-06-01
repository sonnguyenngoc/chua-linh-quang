class AddApprovedAndUserIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :approved, :boolean, default: false
    add_column :products, :user_id, :integer
  end
end
