class Admin::BannersController < ApplicationController
  before_action :set_banner, only: [:show, :edit, :update, :destroy]

  # GET /banners
  # GET /banners.json
  def index
    # authorize
    authorize! :read, Banner
    @banners = Banner.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  end

  # GET /banners/1
  # GET /banners/1.json
  def show
  end

  # GET /banners/new
  def new
    # authorize
    authorize! :create, Banner
    @banner = Banner.new
  end

  # GET /banners/1/edit
  def edit
    # authorize
    authorize! :update, @banner
  end

  # POST /banners
  # POST /banners.json
  def create
    # authorize
    authorize! :create, Banner
    @banner = Banner.new(banner_params)

    respond_to do |format|
      if @banner.save
        format.html { redirect_to edit_admin_banner_path(@banner.id), notice: 'Tạo banner thành công.' }
        format.json { render :show, status: :created, location: @banner }
      else
        format.html { render :new }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banners/1
  # PATCH/PUT /banners/1.json
  def update
    # authorize
    authorize! :update, @banner
    respond_to do |format|
      if @banner.update(banner_params)
        format.html { redirect_to edit_admin_banner_path(@banner.id), notice: 'Cập nhật banner thành công.' }
        format.json { render :show, status: :ok, location: @banner }
      else
        format.html { render :edit }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banners/1
  # DELETE /banners/1.json
  def destroy
    # authorize
    authorize! :delete, @banner
    @banner.destroy
    
    render nothing:true
    flash[:notice] = 'Xóa banner thành công.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_banner
      @banner = Banner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def banner_params
      params.require(:banner).permit(:image_url, :title, :banner_type)
    end
end
