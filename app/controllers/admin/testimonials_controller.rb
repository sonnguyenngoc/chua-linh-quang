class Admin::TestimonialsController < ApplicationController
  before_action :set_testimonial, only: [:show, :edit, :update, :destroy]

  # GET /testimonials
  # GET /testimonials.json
  def index
    # authorize
    authorize! :read, Testimonial
    
    @testimonials = Testimonial.search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    # authorize
    authorize! :read, Testimonial
    
    @testimonials = Testimonial.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/testimonials/index"
  end

  # GET /testimonials/1
  # GET /testimonials/1.json
  def show
  end

  # GET /testimonials/new
  def new
    # authorize
    authorize! :create, Testimonial
    
    @testimonial = Testimonial.new
  end

  # GET /testimonials/1/edit
  def edit
    # authorize
    authorize! :update, @testimonial
  end

  # POST /testimonials
  # POST /testimonials.json
  def create
    # authorize
    authorize! :create, Testimonial
    @testimonial = Testimonial.new(testimonial_params)

    respond_to do |format|
      if @testimonial.save
        format.html { redirect_to edit_admin_testimonial_path(@testimonial.id), notice: 'Testimonial was successfully created.' }
        format.json { render :show, status: :created, location: @testimonial }
      else
        format.html { render :new }
        format.json { render json: @testimonial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /testimonials/1
  # PATCH/PUT /testimonials/1.json
  def update
    # authorize
    authorize! :update, @testimonial
    
    respond_to do |format|
      if @testimonial.update(testimonial_params)
        format.html { redirect_to edit_admin_testimonial_path(@testimonial.id), notice: 'Testimonial was successfully updated.' }
        format.json { render :show, status: :ok, location: @testimonial }
      else
        format.html { render :edit }
        format.json { render json: @testimonial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /testimonials/1
  # DELETE /testimonials/1.json
  def destroy
    # authorize
    authorize! :delete, @testimonial
    @testimonial.destroy
    format.html { redirect_to admin_testimonials_url, notice: 'Xóa ý kiến khách hàng thành công.' }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_testimonial
      @testimonial = Testimonial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def testimonial_params
      params.require(:testimonial).permit(:name, :city, :email, :content, :user_id)
    end
end
