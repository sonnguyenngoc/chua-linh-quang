class Admin::OptionsController < ApplicationController
  before_action :set_option, only: [:show, :edit, :update, :destroy]

  # GET /options
  # GET /options.json
  def index
    # authorize
    authorize! :read, Option
    
    @options = Option.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /options/1
  # GET /options/1.json
  def show
  end

  # GET /options/new
  def new
    # authorize
    authorize! :create, Option
    
    @option = Option.new
  end

  # GET /options/1/edit
  def edit
    # authorize
    authorize! :update, @option
  end

  # POST /options
  # POST /options.json
  def create
    # authorize
    authorize! :create, Option
    @option = Option.new(option_params)

    respond_to do |format|
      if @option.save
        format.html { redirect_to edit_admin_option_path(@option.id), notice: 'Tạo mới cài đặt thành công.' }
        format.json { render :show, status: :created, location: @option }
      else
        format.html { render :new }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /options/1
  # PATCH/PUT /options/1.json
  def update
    # authorize
    authorize! :update, @option
    respond_to do |format|
      if @option.update(option_params)
        format.html { redirect_to edit_admin_option_path(@option.id), notice: 'Chỉnh sửa cài đặt thành công.' }
        format.json { render :show, status: :ok, location: @option }
      else
        format.html { render :edit }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /options/1
  # DELETE /options/1.json
  def destroy
    # authorize
    authorize! :delete, @option
    @option.destroy
    respond_to do |format|
      format.html { redirect_to admin_options_url, notice: 'Xóa cài đặt thành công.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_option
      @option = Option.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def option_params
      params.require(:option).permit(:title, :tag, :value, :note, :accept_email)
    end
end
