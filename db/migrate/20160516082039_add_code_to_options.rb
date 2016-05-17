class AddCodeToOptions < ActiveRecord::Migration
  def change
    add_column :options, :code, :string
  end
end
