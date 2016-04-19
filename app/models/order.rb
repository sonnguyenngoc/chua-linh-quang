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
  
  #get order for user
  def self.get_by_order(current_user)
    records = self.all
    records = records.where(user_id: {id: params[:current_id]})
    return records
  end
  
  def total
    amount = 0.0
    order_details.each do |od|
      amount += od.total
    end
    return amount
  end
end
