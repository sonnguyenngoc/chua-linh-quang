class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :image_url
      t.string :name
      t.string :head_office_address
      t.string :certificate_no
      t.datetime :date_of_issue
      t.string :sales_office_address
      t.string :phone
      t.string :hotline
      t.string :email

      t.timestamps null: false
    end
  end
end
