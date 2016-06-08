class Admin::CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  # GET /coupons
  # GET /coupons.json
  def index
    # authorize
    authorize! :read, Coupon
    
    @coupons = Coupon.search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    # authorize
    authorize! :read, Coupon
    
    @coupons = Coupon.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/coupons/index"
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
  end

  # GET /coupons/new
  def new
    # authorize
    authorize! :create, Coupon
    
    @coupon = Coupon.new
    @coupon.from_date = Time.now
    @coupon.to_date = Time.now
  end

  # GET /coupons/1/edit
  def edit
    # authorize
    authorize! :update, @coupon
  end

  # POST /coupons
  # POST /coupons.json
  def create
    # authorize
    authorize! :create, Coupon
    @coupon = Coupon.new(coupon_params)
    
    @coupon.generate_codes

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to edit_admin_coupon_path(@coupon.id), notice: 'Tạo mới mã giảm giá thành công.' }
        format.json { render :show, status: :created, location: @coupon }
      else
        format.html { render :new }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    # authorize
    authorize! :update, @coupon
    
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to edit_admin_coupon_path(@coupon.id), notice: 'Chỉnh sửa mã giảm giá thành công.' }
        format.json { render :show, status: :ok, location: @coupon }
      else
        format.html { render :edit }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    # authorize
    authorize! :delete, @coupon
    @coupon.destroy
    
    render nothing:true
    flash[:notice] = 'Xóa mã giảm giá thành công.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:name, :code, :price, :from_date, :to_date, :description, :quantity)
    end
end
