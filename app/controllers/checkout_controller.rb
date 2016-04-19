class CheckoutController < ApplicationController
  def shopping_cart
    @title_head = "Giỏ hàng"
    @cart.remove_item(params[:line_item_id]) if params[:do] == "remove_item"
  end
  
  def checkout
    @title_head = "Đặt hàng"
    @order = Order.new
    @customer = Customer.new
  end
  
  def success
    @title_head = "Kết thúc đặt hàng"
  end
end
