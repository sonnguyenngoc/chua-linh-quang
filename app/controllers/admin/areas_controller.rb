class Admin::AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  # GET /areas
  # GET /areas.json
  def index
    # authorize
    authorize! :read, Area
    
    @areas = Area.search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    # authorize
    authorize! :read, Area
    
    @areas = Area.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/areas/index"
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
  end

  # GET /areas/new
  def new
    # authorize
    authorize! :create, Area
    
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
    # authorize
    authorize! :update, Area
  end

  # POST /areas
  # POST /areas.json
  def create
    # authorize
    authorize! :create, Area
    
    @area = Area.new(area_params)

    respond_to do |format|
      if @area.save
        format.html { redirect_to edit_admin_area_path(@area.id), notice: 'Area was successfully created.' }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    # authorize
    authorize! :update, Area
    
    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to edit_admin_area_path(@area.id), notice: 'Area was successfully updated.' }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    # authorize
    authorize! :delete, Area
    
    @area.destroy
    respond_to do |format|
      format.html { redirect_to admin_areas_url, notice: 'Area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:name, :level, :parent_id, :description, :display_order)
    end
end
