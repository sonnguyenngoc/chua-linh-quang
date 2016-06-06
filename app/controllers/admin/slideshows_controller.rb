class Admin::SlideshowsController < ApplicationController
  before_action :set_slideshow, only: [:show, :edit, :update, :destroy]

  # GET /slideshows
  # GET /slideshows.json
  def index
    # authorize
    authorize! :read, Slideshow
    
    @slideshows = Slideshow.all.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /slideshows/1
  # GET /slideshows/1.json
  def show
  end

  # GET /slideshows/new
  def new
    # authorize
    authorize! :create, Slideshow
    
    @slideshow = Slideshow.new
  end

  # GET /slideshows/1/edit
  def edit
    # authorize
    authorize! :update, @slideshow
  end

  # POST /slideshows
  # POST /slideshows.json
  def create
    # authorize
    authorize! :create, Slideshow
    @slideshow = Slideshow.new(slideshow_params)
    
    respond_to do |format|
      if @slideshow.save
        format.html { redirect_to edit_admin_slideshow_path(@slideshow.id), notice: 'Tạo mới trình chiếu thành công.' }
        format.json { render :show, status: :created, location: @slideshow }
      else
        format.html { render :new }
        format.json { render json: @slideshow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slideshows/1
  # PATCH/PUT /slideshows/1.json
  def update
    # authorize
    authorize! :update, @slideshow
    
    respond_to do |format|
      if @slideshow.update(slideshow_params)
        format.html { redirect_to edit_admin_slideshow_path(@slideshow.id), notice: 'Chỉnh sửa trình chiếu thành công.' }
        format.json { render :show, status: :ok, location: @slideshow }
      else
        format.html { render :edit }
        format.json { render json: @slideshow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slideshows/1
  # DELETE /slideshows/1.json
  def destroy
    # authorize
    authorize! :delete, @slideshow
    
    @slideshow.destroy
    respond_to do |format|
      format.html { redirect_to admin_slideshows_url, notice: 'Xóa trình chiếu thành công.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slideshow
      @slideshow = Slideshow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slideshow_params
      params.require(:slideshow).permit(:image_url, :title_1, :color_1, :title_2, :color_2, :name_button, :link, :style)
    end
end
