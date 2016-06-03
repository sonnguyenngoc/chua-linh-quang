class Admin::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    # authorize
    authorize! :read, Order
    
    @orders = Order.get_order_pending.paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    # authorize
    authorize! :read, Order
    
    @orders = Order.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/orders/index"
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    # authorize
    authorize! :create, Order
    
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    # authorize
    authorize! :update, @order
  end

  # POST /orders
  # POST /orders.json
  def create
    # authorize
    authorize! :create, Order
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to [:admin, @order], notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    # authorize
    authorize! :update, @order
    
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to [:admin, @order], notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    # authorize
    authorize! :delete, @order
    
    @order.destroy
    respond_to do |format|
      format.html { redirect_to admin_orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def pending
    @order = Order.find(params[:id])
    @order.status = "pending"
    @order.save
    respond_to do |format|
      format.html { redirect_to admin_orders_url }
      format.json { head :no_content }
    end
  end
  
  def finish
    @order = Order.find(params[:id])
    @order.status = "finished"
    @order.save
    respond_to do |format|
      format.html { redirect_to admin_orders_url }
      format.json { head :no_content }
    end
  end
  
  def cancel
    @order = Order.find(params[:id])
    @order.status = "cancel"
    @order.save
    respond_to do |format|
      format.html { redirect_to admin_orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:customer_id, order_detail_id, order_delivery_id)
    end
end
