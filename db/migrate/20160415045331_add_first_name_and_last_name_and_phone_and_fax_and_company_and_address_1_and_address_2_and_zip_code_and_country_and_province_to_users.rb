class AddFirstNameAndLastNameAndPhoneAndFaxAndCompanyAndAddress1AndAddress2AndZipCodeAndCountryAndProvinceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :fax, :integer
    add_column :users, :company, :string
    add_column :users, :address_1, :string
    add_column :users, :address_2, :string
    add_column :users, :zip_code, :integer
    add_column :users, :country, :string
    add_column :users, :province, :string
  end
end
