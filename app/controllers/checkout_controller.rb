class CheckoutController < ApplicationController
  def shopping_cart
    @title_head = "Giỏ hàng"
    @cart.remove_item(params[:line_item_id]) if params[:do] == "remove_item"
  end
end
