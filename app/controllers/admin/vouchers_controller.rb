class Admin::VouchersController < ApplicationController
  before_action :set_voucher, only: [:show, :edit, :update, :destroy]

  # GET /vouchers
  # GET /vouchers.json
  def index
    # authorize
    authorize! :read, Voucher
    
    @vouchers = Voucher.search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    # authorize
    authorize! :read, Voucher
    
    @vouchers = Voucher.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/vouchers/index"
  end


  # GET /vouchers/1
  # GET /vouchers/1.json
  def show
  end

  # GET /vouchers/new
  def new
    # authorize
    authorize! :create, Voucher
    
    @voucher = Voucher.new
    @voucher.from_date = Time.now
    @voucher.to_date = Time.now
  end

  # GET /vouchers/1/edit
  def edit
    # authorize
    authorize! :update, @voucher
  end

  # POST /vouchers
  # POST /vouchers.json
  def create
    # authorize
    authorize! :create, Voucher
    @voucher = Voucher.new(voucher_params)
    
    @voucher.generate_codes

    respond_to do |format|
      if @voucher.save
        
        format.html { redirect_to edit_admin_voucher_path(@voucher.id), notice: 'Voucher was successfully created.' }
        format.json { render :show, status: :created, location: @voucher }
      else
        format.html { render :new }
        format.json { render json: @voucher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vouchers/1
  # PATCH/PUT /vouchers/1.json
  def update
    # authorize
    authorize! :update, @voucher
    
    respond_to do |format|
      if @voucher.update(voucher_params)
        format.html { redirect_to edit_admin_voucher_path(@voucher.id), notice: 'Voucher was successfully updated.' }
        format.json { render :show, status: :ok, location: @voucher }
      else
        format.html { render :edit }
        format.json { render json: @voucher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vouchers/1
  # DELETE /vouchers/1.json
  def destroy
    # authorize
    authorize! :delete, @voucher
    
    @voucher.destroy
    respond_to do |format|
      format.html { redirect_to admin_vouchers_url, notice: 'Voucher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voucher
      @voucher = Voucher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def voucher_params
      params.require(:voucher).permit(:name, :code, :price, :from_date, :to_date, :description, :quantity)
    end
end
