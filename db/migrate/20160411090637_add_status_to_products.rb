class AddStatusToProducts < ActiveRecord::Migration
  def change
    add_column :products, :status, :text
  end
end
