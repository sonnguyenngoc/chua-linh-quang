class Admin::DeliveryMethodsController < ApplicationController
  before_action :set_delivery_method, only: [:show, :edit, :update, :destroy]

  # GET /delivery_methods
  # GET /delivery_methods.json
  def index
    # authorize
    authorize! :read, DeliveryMethod
    
    @delivery_methods = DeliveryMethod.order("created_at DESC").search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    # authorize
    authorize! :read, DeliveryMethod
    
    @delivery_methods = DeliveryMethod.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/delivery_methods/index"
  end

  # GET /delivery_methods/1 
  # GET /delivery_methods/1.json
  def show
  end

  # GET /delivery_methods/new
  def new
    # authorize
    authorize! :create, DeliveryMethod
    
    @delivery_method = DeliveryMethod.new
  end

  # GET /delivery_methods/1/edit
  def edit
    # authorize
    authorize! :update, @delivery_method
  end

  # POST /delivery_methods
  # POST /delivery_methods.json
  def create
    # authorize
    authorize! :create, DeliveryMethod
    @delivery_method = DeliveryMethod.new(delivery_method_params)
    
    respond_to do |format|
      if @delivery_method.save
        format.html { redirect_to edit_admin_delivery_method_path(@delivery_method.id), notice: 'Tạo mới hình thức vận chuyển thành công.' }
        format.json { render :show, status: :created, location: @delivery_method }
      else
        format.html { render :new }
        format.json { render json: @delivery_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delivery_methods/1
  # PATCH/PUT /delivery_methods/1.json
  def update
    # authorize
    authorize! :update, @delivery_method
    
    respond_to do |format|
      if @delivery_method.update(delivery_method_params)
        format.html { redirect_to edit_admin_delivery_method_path(@delivery_method.id), notice: 'Chỉnh sửa hình thức vận chuyển thành công.' }
        format.json { render :show, status: :ok, location: @delivery_method }
      else
        format.html { render :edit }
        format.json { render json: @delivery_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_methods/1
  # DELETE /delivery_methods/1.json
  def destroy
    # authorize
    authorize! :delete, @delivery_method
    @delivery_method.destroy
    
    render nothing:true
    flash[:notice] = 'Xóa hình thức giao hàng thành công.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery_method
      @delivery_method = DeliveryMethod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_method_params
      params.require(:delivery_method).permit(:title, :description)
    end
end
