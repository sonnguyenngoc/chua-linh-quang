class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    # authorize
    authorize! :read, Category
    
    respond_to do |format|
        format.html { 
          @categories = Category.get_categories #.paginate(:page => params[:page], :per_page => 10)
        }
        format.json { render json: Category.get_tree_json(current_user) }
    end
    
  end
  
  def search
    # authorize
    authorize! :read, Category
    
    @categories = Category.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/categories/index"
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    # authorize
    authorize! :create, Category
    
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    # authorize
    authorize! :update, @category
  end

  # POST /categories
  # POST /categories.json
  def create
    # authorize
    authorize! :create, Category
    @category = Category.new(category_params)
    
    respond_to do |format|
      if @category.save
        # update parent
        @category.parent.clear
        @category.parent << Category.find(params[:parent_id]) if params[:parent_id].present?
        
        # update all level
        Category.update_all_level
        
        format.html { redirect_to edit_admin_category_path(@category.id), notice: 'Tạo mới chuyên mục thành công.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    # authorize
    authorize! :update, @category
    
    respond_to do |format|
      if @category.update(category_params)
        # update parent
        @category.parent.clear
        @category.parent << Category.find(params[:parent_id]) if params[:parent_id].present?
        # update all level
        Category.update_all_level
        
        format.html { redirect_to edit_admin_category_path(@category.id), notice: 'Cập nhật chuyên mục thành công.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    # authorize
    authorize! :delete, @category
    @category.destroy
    Category.update_all_level
    
    render text: admin_categories_url
    flash[:notice] = 'Xóa chuyên mục sản phẩm thành công.'
  end
  
  # ajax update categories ordered parent
  def update_parent_order
    items = JSON.parse params[:data]
    items.each do |item|
      cat = Category.find(item["id"])
      cat.parent.clear
      cat.parent << Category.find(item["parent"]) if !item["parent"].empty?
      cat.ordered = item["ordered"]
      puts item["ordered"]+"sssss"
      puts cat.save
    end
    Category.update_all_level
    render text: items.count.to_s
  end
  
  def three_cols_select
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
    end
      
    render layout: nil
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :level, :meta_keywords, :meta_description, :description, parent_ids: [])
    end
end
