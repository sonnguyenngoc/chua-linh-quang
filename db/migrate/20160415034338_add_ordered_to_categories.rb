class AddOrderedToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :ordered, :integer
  end
end
