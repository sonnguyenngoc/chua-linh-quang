class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  
  def total_item
    product.price*quantity
  end
  
  def self.count_items
    count = 0
    self.all.each do |item|
      count += item.quantity
    end
    
    return count
  end
end
