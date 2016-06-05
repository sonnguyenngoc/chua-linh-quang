class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :approve, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    # authorize
    authorize! :read, Product
  
    @products = Product.search_backend(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search_backend
    # authorize
    authorize! :read, Product
    
    @products = Product.search_backend(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/products/index"
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    
    # authorize
    authorize! :create, Product
    
    @categories = Category.all
    @areas = Area.all
    10.times do
      @product.product_images.build
    end
    @articles = @product.articles.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /products/1/edit
  def edit
    # authorize
    authorize! :update, @product
    
    @categories = Category.all
    @category = @product.categories.first
    
    @areas = Area.all
    (10-@product.product_images.count).times do
      @product.product_images.build
    end
    @articles = Article.paginate(:page => params[:page], :per_page => 10)
  end

  # POST /products
  # POST /products.json
  def create
    # authorize
    authorize! :create, Product
    @product = Product.new(product_params)
    
    @product.user_id = current_user.id
    
    @product.categories.clear
    @categories = Category.all
    @articles = Article.all
    
    # update category id    
    if params[:category_ids].present?
      catid = nil
      params[:category_ids].each do |id|      
        catid = id if id.present? 
      end
      @category = Category.find(catid) if catid.present?
      @product.categories << Category.find(catid) if catid.present?
    end    
    
    
    @product.areas.clear
    if params[:area_ids].present?
      params[:area_ids].each do |id|      
        @product.areas << Area.find(id)
      end
    end
    
    @product.articles.clear
    if params[:article_ids].present?
      params[:article_ids].each do |id|      
        @product.articles << Article.find(id)
      end
    end

    respond_to do |format|
      if @product.save
        format.html { redirect_to edit_admin_product_path(@product.id), notice: 'Tạo mới sản phẩm thành công.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    
    # authorize
    authorize! :update, @product
    
    @categories = Category.all
    @articles = Article.all
    if params[:category_ids].present?
        @product.categories.clear
        # update category id
        catid = nil
        params[:category_ids].each do |id|      
          catid = id if id.present?
        end
        @category = Category.find(catid) if catid.present?
        @product.categories << Category.find(catid) if catid.present?
    end   
    
    @product.areas.clear
    if params[:area_ids].present?
        @product.areas.clear
        params[:area_ids].each do |id|      
          @product.areas << Area.find(id)
        end
    end
    
    if params[:article_ids].present?
      @product.articles.clear
      params[:article_ids].each do |id|      
        @product.articles << Article.find(id)
      end
    end
    
    # update status
    @product.status = nil if params[:product][:status].present?
    @product.status = params[:product][:status].join(",") if params[:product][:status].present?
    
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to edit_admin_product_path(@product.id), notice: 'Chỉnh sửa sản phẩm thành công.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    # authorize
    authorize! :delete, @product
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: 'Xóa sản phẩm thành công.' }
      format.json { head :no_content }
    end
  end
  
  def approve
    authorize! :approve, @product
    @product = Product.find(params[:id])
    @product.approved = true
    @product.save
    respond_to do |format|
      format.html { redirect_to admin_products_url }
      format.json { head :no_content }
    end
  end
  
  def add_related_articles
    if params[:article_ids].present?
      @articles = Article.where(id: params[:article_ids].split(","))
      render "/admin/products/_table_related_articles"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:is_show, :stock, :name, :code, :quantity, :unit, :price, :old_price, :discount_percent, :tags, :short_description, :description, :status, :manufacturer_id, :product_image_id, :meta_keywords, :meta_description, product_images_attributes: [:id, :image_url, :is_main, :_destroy])
    end
end
