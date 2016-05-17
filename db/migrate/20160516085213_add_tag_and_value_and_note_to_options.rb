class AddTagAndValueAndNoteToOptions < ActiveRecord::Migration
  def change
    add_column :options, :tag, :string
    add_column :options, :value, :text
    add_column :options, :note, :text
  end
end
