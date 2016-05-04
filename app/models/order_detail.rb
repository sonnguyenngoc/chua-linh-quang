class OrderDetail < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  
  before_validation :update_current_price_from_product
  before_validation :update_current_name_from_product
  
  def update_current_price_from_product
    if self.price.nil?
        self.price = product.price
    end    
  end
    
  def update_current_name_from_product
    if self.product_name.nil?
        self.product_name = product.name
    end    
  end
  
  def total
    price*quantity
  end
  
  def numerical
    count = 0
    self.each 
  end
  
  def self.get_order_details
    #records = self.all
    #records = records.where(order_id: params[:order_id])
    #return records
  end
  
end
