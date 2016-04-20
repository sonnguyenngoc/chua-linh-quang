class Compare < ActiveRecord::Base
  has_many :line_item_compares, dependent: :destroy
  
  def get_number_items
    self.line_item_compares.count
  end

end
