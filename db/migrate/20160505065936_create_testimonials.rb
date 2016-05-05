class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.string :name
      t.string :city
      t.string :email
      t.string :content
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
