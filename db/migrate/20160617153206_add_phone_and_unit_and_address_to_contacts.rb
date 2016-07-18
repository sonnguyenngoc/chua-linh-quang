class AddPhoneAndUnitAndAddressToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :phone, :string
    add_column :contacts, :unit, :string
    add_column :contacts, :address, :string
  end
end
