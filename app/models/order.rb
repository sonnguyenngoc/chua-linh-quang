class Order < ActiveRecord::Base
  has_many :order_details, dependent: :destroy
  has_one :customer, dependent: :destroy
  has_one :order_delivery, dependent: :destroy
  
  #save cart
  def save_from_cart(cart)
    cart.line_items.each do |item|
      self.order_details.create(product_id: item.product_id, quantity: item.quantity)
    end
  end
end
