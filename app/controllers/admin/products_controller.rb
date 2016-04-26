class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    @products = Product.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/products/index"
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @categories = Category.all
    @areas = Area.all
    10.times do
      @product.product_images.build
    end
    @articles = Article.all
  end

  # GET /products/1/edit
  def edit
    @categories = Category.all
    @areas = Area.all
    (10-@product.product_images.count).times do
      @product.product_images.build
    end
    @articles = Article.all
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.categories.clear
    if params[:category_ids].present?
      params[:category_ids].each do |id|      
        @product.categories << Category.find(id)
      end
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
        format.html { redirect_to edit_admin_product_path(@product.id), notice: 'Product was successfully created.' }
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
  
    if params[:category_ids].present?
        @product.categories.clear
        params[:category_ids].each do |id|      
          @product.categories << Category.find(id)
        end
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
        format.html { redirect_to edit_admin_product_path(@product.id), notice: 'Product was successfully updated.' }
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
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :code, :quantity, :unit, :price, :tags, :short_description, :description, :status, :manufacturer_id, :product_image_id, product_images_attributes: [:id, :image_url, :is_main, :_destroy])
    end
end
