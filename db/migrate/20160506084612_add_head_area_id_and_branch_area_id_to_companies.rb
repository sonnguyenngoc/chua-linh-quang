class AddHeadAreaIdAndBranchAreaIdToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :head_area_id, :integer
    add_column :companies, :branch_area_id, :integer
  end
end
