class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.datetime :from_date
      t.datetime :to_date
      t.text :description
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
