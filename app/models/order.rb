class Order < ActiveRecord::Base
  has_many :order_details, dependent: :destroy
  has_one :customer
  has_one :order_delivery
  accepts_nested_attributes_for :order_details, :reject_if => lambda { |a| a[:product_id].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :order_delivery
  
  def save_from_cart(cart)
    cart.line_items.each do |item|
      self.order_details.create(product_id: item.product_id, quantity: item.quantity)
    end
  end
end
