class OrderDetail < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  
  before_validation :update_current_price_from_product
  
    def update_current_price_from_product
      if self.price.nil?
          self.price = product.price
      end    
    end
    
end
