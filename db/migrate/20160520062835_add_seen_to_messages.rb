class AddSeenToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :seen, :datetime
  end
end
