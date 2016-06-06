class Admin::NewslettersController < ApplicationController
  before_action :set_newsletter, only: [:show, :edit, :update, :destroy]

  # GET /newsletters
  # GET /newsletters.json
  def index
    # authorize
    authorize! :read, Newsletter
    
    @newsletters = Newsletter.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /newsletters/1
  # GET /newsletters/1.json
  def show
  end

  # GET /newsletters/new
  def new
    # authorize
    authorize! :read, Newsletter
    
    @newsletter = Newsletter.new
  end

  # GET /newsletters/1/edit
  def edit
    # authorize
    authorize! :read, @newsletter
  end

  # POST /newsletters
  # POST /newsletters.json
  def create
    # authorize
    authorize! :read, Newsletter
    @newsletter = Newsletter.new(newsletter_params)

    respond_to do |format|
      if @newsletter.save
        format.html { redirect_to [:admin, @newsletter], notice: 'Newsletter was successfully created.' }
        format.json { render :show, status: :created, location: @newsletter }
      else
        format.html { render :new }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /newsletters/1
  # PATCH/PUT /newsletters/1.json
  def update
    # authorize
    authorize! :read, @newsletter
    
    respond_to do |format|
      if @newsletter.update(newsletter_params)
        format.html { redirect_to [:admin, @newsletter], notice: 'Newsletter was successfully updated.' }
        format.json { render :show, status: :ok, location: @newsletter }
      else
        format.html { render :edit }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newsletters/1
  # DELETE /newsletters/1.json
  def destroy
    # authorize
    authorize! :read, @newsletter
    
    @newsletter.destroy
    respond_to do |format|
      format.html { redirect_to admin_newsletters_url, notice: 'Xóa email thành công.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsletter
      @newsletter = Newsletter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newsletter_params
      params.require(:newsletter).permit(:email)
    end
end
