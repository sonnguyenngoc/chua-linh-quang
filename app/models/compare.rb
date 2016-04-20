class Compare < ActiveRecord::Base
  has_many :line_item_compares, dependent: :destroy
  
  def get_number_items
    self.line_item_compares.count
  end
  
  def remove_item(line_item_compare_id)
    self.line_item_compares.where(id: line_item_compare_id).destroy_all
  end

end
