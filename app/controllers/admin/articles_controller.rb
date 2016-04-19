class Admin::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    @articles = Article.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/articles/index"
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
    @article_categories = ArticleCategory.all
    @products = Product.all
  end

  # GET /articles/1/edit
  def edit
    @article_categories = ArticleCategory.all
    @products = Product.all
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.article_categories.clear
    if params[:category_ids].present?
      params[:category_ids].each do |id|      
        @article.article_categories << ArticleCategory.find(id)
      end
    end
    
    @article.products.clear
    if params[:product_ids].present?
      params[:product_ids].each do |id|      
        @article.products << Product.find(id)
      end
    end

    respond_to do |format|
      if @article.save
        format.html { redirect_to edit_admin_article_path(@article.id), notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article.article_categories.clear
    if params[:category_ids].present?
        @article.article_categories.clear
        params[:category_ids].each do |id|      
          @article.article_categories << ArticleCategory.find(id)
        end
    end
    
    if params[:product_ids].present?
       @article.products.clear
      params[:product_ids].each do |id|      
        @article.products << Product.find(id)
      end
    end
    
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to edit_admin_article_path(@article.id), notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:image_url, :title, :content, :tags, :article_category_id, :code)
    end
end
