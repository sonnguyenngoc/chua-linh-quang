class CreateLineItemCompares < ActiveRecord::Migration
  def change
    create_table :line_item_compares do |t|
      t.references :product, index: true, foreign_key: true
      t.belongs_to :compare, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
