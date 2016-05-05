class Admin::CodeStatusesController < ApplicationController
  before_action :set_code_status, only: [:show, :edit, :update, :destroy]

  # GET /code_statuses
  # GET /code_statuses.json
  def index
    @code_statuses = CodeStatus.all.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /code_statuses/1
  # GET /code_statuses/1.json
  def show
  end

  # GET /code_statuses/new
  def new
    @code_status = CodeStatus.new
  end

  # GET /code_statuses/1/edit
  def edit
  end

  # POST /code_statuses
  # POST /code_statuses.json
  def create
    @code_status = CodeStatus.new(code_status_params)

    respond_to do |format|
      if @code_status.save
        format.html { redirect_to edit_admin_code_status_path(@code_status.id), notice: 'Code status was successfully created.' }
        format.json { render :show, status: :created, location: @code_status }
      else
        format.html { render :new }
        format.json { render json: @code_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /code_statuses/1
  # PATCH/PUT /code_statuses/1.json
  def update
    respond_to do |format|
      if @code_status.update(code_status_params)
        format.html { redirect_to edit_admin_code_status_path(@code_status.id), notice: 'Code status was successfully updated.' }
        format.json { render :show, status: :ok, location: @code_status }
      else
        format.html { render :edit }
        format.json { render json: @code_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /code_statuses/1
  # DELETE /code_statuses/1.json
  def destroy
    @code_status.destroy
    respond_to do |format|
      format.html { redirect_to admin_code_statuses_url, notice: 'Code status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code_status
      @code_status = CodeStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def code_status_params
      params.require(:code_status).permit(:title, :description)
    end
end
