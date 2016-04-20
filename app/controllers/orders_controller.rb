class OrdersController < ApplicationController

  # POST /orders
  # POST /orders.json
  def create
    if params[:order].present?
      @order = Order.new(order_params)
    else
      @order = Order.new
    end
    @customer = Customer.new(customer_params)
    @order.customer = @customer
    if @order.different_delivery == true
      @order_delivery = OrderDelivery.new(
        first_name: @customer.first_name,
        last_name: @customer.last_name,
        email: @customer.email,
        phone: @customer.phone,
        company: @customer.company,
        zip_code: @customer.zip_code,
        address: @customer.address,
      )
    else
      @order_delivery = OrderDelivery.new(order_delivery_params)
    end
    
    @order.order_delivery = @order_delivery
    
    @order.user_id = current_user.id if current_user.present?
    
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
      params.require(:order).permit(:different_delivery, order_details_attributes: [:id, :order_id, :product_id, :quantity, :_destroy])
    end
    
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email, :phone, :company, :address, :city, :zip_code, :country, :province)
    end
    
    def order_delivery_params
      params.require(:order_delivery).permit(:first_name, :last_name, :company, :address, :city, :zip_code, :country, :province, :delivery_method_id, :payment_method_id, :message)
    end
end
