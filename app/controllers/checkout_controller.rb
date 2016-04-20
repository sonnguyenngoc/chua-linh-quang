class CheckoutController < ApplicationController
  def shopping_cart
    @title_head = "Giỏ hàng"
    @cart.remove_item(params[:line_item_id]) if params[:do] == "remove_item"
  end
  
  def checkout
    @title_head = "Đặt hàng"
    if @cart.line_items.empty?
      redirect_to shopping_cart_path
    end
    @order = Order.new
    @customer = Customer.new
    session[:user_return_to] = checkout_path
  end
  
  def success
    @title_head = "Kết thúc đặt hàng"
  end
end
