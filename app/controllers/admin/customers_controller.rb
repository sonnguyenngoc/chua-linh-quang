class Admin::CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @areas = Area.get_by_level(2)
    # authorize
    authorize! :read, Customer
    
    @customers = Customer.order("created_at DESC").search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    @areas = Area.get_by_level(2)
    # authorize
    authorize! :read, Customer
    
    @customers = Customer.search(params).paginate(:page => params[:page], :per_page => 10)
    render 'admin/customers/index'
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    # authorize
    authorize! :create, Customer
    
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
    # authorize
    authorize! :update, @customer
  end

  # POST /customers
  # POST /customers.json
  def create
    # authorize
    authorize! :create, Customer
    @customer = Customer.new(customer_params)
    
    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    # authorize
    authorize! :update, @customer
    
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    # authorize
    authorize! :delete, @customer
    
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Xóa khách hàng thành công.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email, :phone, :company, :address, :city, :zip_code, :country, :province, :order_id, :area_id)
    end
end
