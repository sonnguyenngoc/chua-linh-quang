class Admin::CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    # authorize
    authorize! :read, Company
    
    @companies = Company.where(type_company: "Branch Office").order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  end
  
  # GET /companies
  # GET /companies.json
  def head_office
    # authorize
    authorize! :read, Company
    
    @companies = Company.where(type_company: "Head Office").paginate(:page => params[:page], :per_page => 10)
  end
  
  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    # authorize
    authorize! :create, Company
    
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
    # authorize
    authorize! :update, @company
  end

  # POST /companies
  # POST /companies.json
  def create
    # authorize
    authorize! :create, Company
    @company = Company.new(company_params)
    
    respond_to do |format|
      if @company.save
        format.html { redirect_to edit_admin_company_path(@company.id), notice: 'Tạo mới thông tin công ty thành công.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    # authorize
    authorize! :update, @company
    
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to edit_admin_company_path(@company.id), notice: 'Chỉnh sửa thông tin công ty thành công.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    # authorize
    authorize! :delete, @company
    @company.destroy
    
    render nothing:true
    flash[:notice] = 'Xóa công ty/chi nhánh thành công.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:image_url, :name, :head_office_address, :certificate_no, :date_of_issue, :sales_office_address, :phone, :hotline, :email, :type_company, :head_area_id, :branch_area_id)
    end
end
