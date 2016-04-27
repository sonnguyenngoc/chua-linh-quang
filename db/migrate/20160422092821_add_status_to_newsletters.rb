class AddStatusToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :status, :boolean, default: true
  end
end
