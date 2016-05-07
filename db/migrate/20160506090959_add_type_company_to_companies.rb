class AddTypeCompanyToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :type_company, :string
  end
end
