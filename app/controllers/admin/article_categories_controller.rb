class Admin::ArticleCategoriesController < ApplicationController
  before_action :set_article_category, only: [:show, :edit, :update, :destroy]

  # GET /article_categories
  # GET /article_categories.json
  def index
    # authorize
    authorize! :read, ArticleCategory
    
    @article_categories = ArticleCategory.search(params)
  end
  
  def search
    # authorize
    authorize! :read, ArticleCategory
    
    @article_categories = ArticleCategory.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/article_categories/index"
  end

  # GET /article_categories/1
  # GET /article_categories/1.json
  def show
  end

  # GET /article_categories/new
  def new
    # authorize
    authorize! :create, ArticleCategory
    
    @article_category = ArticleCategory.new
  end

  # GET /article_categories/1/edit
  def edit
    # authorize
    authorize! :update, @article_category
  end

  # POST /article_categories
  # POST /article_categories.json
  def create
    # authorize
    authorize! :create, ArticleCategory
    @article_category = ArticleCategory.new(article_category_params)

    respond_to do |format|
      if @article_category.save
        # update parent
        @article_category.parent.clear
        @article_category.parent << ArticleCategory.find(params[:parent_id]) if params[:parent_id].present?
        
        format.html { redirect_to edit_admin_article_category_path(@article_category.id), notice: 'Tạo mới chuyên mục bài viết thành công.' }
        format.json { render :show, status: :created, location: @article_category }
      else
        format.html { render :new }
        format.json { render json: @article_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_categories/1
  # PATCH/PUT /article_categories/1.json
  def update
    # authorize
    authorize! :update, @article_category
    
    respond_to do |format|
      if @article_category.update(article_category_params)
        # update parent
        @article_category.parent.clear
        @article_category.parent << ArticleCategory.find(params[:parent_id]) if params[:parent_id].present?
        
        format.html { redirect_to edit_admin_article_category_path(@article_category.id), notice: 'Chỉnh sửa chuyên mục bài viết thành công.' }
        format.json { render :show, status: :ok, location: @article_category }
      else
        format.html { render :edit }
        format.json { render json: @article_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /article_categories/1
  # DELETE /article_categories/1.json
  def destroy
    # authorize
    authorize! :delete, @article_category
    @article_category.destroy
    
    render nothing:true
    flash[:notice] = 'Xóa chuyên mục bài viết thành công.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_category
      @article_category = ArticleCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_category_params
      params.require(:article_category).permit(:name, :level, :description, :meta_keywords, :meta_description, parent_ids: [])
    end
end
