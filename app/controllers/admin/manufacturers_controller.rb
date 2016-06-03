class Admin::ManufacturersController < ApplicationController
  before_action :set_manufacturer, only: [:show, :edit, :update, :destroy]

  # GET /manufacturers
  # GET /manufacturers.json
  def index
    # authorize
    authorize! :read, Manufacturer
    
    @manufacturers = Manufacturer.search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    # authorize
    authorize! :read, Manufacturer
    
    @manufacturers = Manufacturer.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/manufacturers/index"
  end

  # GET /manufacturers/1
  # GET /manufacturers/1.json
  def show
  end

  # GET /manufacturers/new
  def new
    # authorize
    authorize! :create, Manufacturer
    
    @manufacturer = Manufacturer.new
  end

  # GET /manufacturers/1/edit
  def edit
    # authorize
    authorize! :update, @manufacturer
  end

  # POST /manufacturers
  # POST /manufacturers.json
  def create
    # authorize
    authorize! :create, Manufacturer
    @manufacturer = Manufacturer.new(manufacturer_params)

    respond_to do |format|
      if @manufacturer.save
        format.html { redirect_to edit_admin_manufacturer_path(@manufacturer.id), notice: 'Manufacturer was successfully created.' }
        format.json { render :show, status: :created, location: @manufacturer }
      else
        format.html { render :new }
        format.json { render json: @manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manufacturers/1
  # PATCH/PUT /manufacturers/1.json
  def update
    # authorize
    authorize! :update, @manufacturer
    
    respond_to do |format|
      if @manufacturer.update(manufacturer_params)
        format.html { redirect_to edit_admin_manufacturer_path(@manufacturer.id), notice: 'Manufacturer was successfully updated.' }
        format.json { render :show, status: :ok, location: @manufacturer }
      else
        format.html { render :edit }
        format.json { render json: @manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manufacturers/1
  # DELETE /manufacturers/1.json
  def destroy
    # authorize
    authorize! :delete, @manufacturer
    
    @manufacturer.destroy
    respond_to do |format|
      format.html { redirect_to admin_manufacturers_url, notice: 'Manufacturer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manufacturer
      @manufacturer = Manufacturer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manufacturer_params
      params.require(:manufacturer).permit(:image_url, :name, :address, :description)
    end
end
