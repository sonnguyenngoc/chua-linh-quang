class OrdersController < ApplicationController

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    #@order_delivery = OrderDelivery.new(params[:order_delivery])
    #@order.order_delivery = @order_delivery
    
    respond_to do |format|
      if @order.save
        @order.save_from_cart(@cart)
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to controller: "checkout", action: "success" }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:customer_id, :order_detail_id, :order_delivery_id, order_details_attributes: [:id, :order_id, :product_id, :quantity, :_destroy])
    end
end
