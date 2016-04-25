class ChangeProvinceInUsers < ActiveRecord::Migration
  def up
    change_column :users, :province, :string
  end
  def down
    change_column :users, :province, :integer
  end
end
