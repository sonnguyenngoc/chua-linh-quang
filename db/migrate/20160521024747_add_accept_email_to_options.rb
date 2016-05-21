class AddAcceptEmailToOptions < ActiveRecord::Migration
  def change
    add_column :options, :accept_email, :boolean, default: false
  end
end
