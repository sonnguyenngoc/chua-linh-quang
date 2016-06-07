class Admin::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    # authorize
    authorize! :read, Article
    
    @articles = Article.order("created_at DESC").search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    # authorize
    authorize! :read, Article
    
    @articles = Article.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/articles/index"
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    # authorize
    authorize! :create, Article
    
    @article = Article.new
    @article_categories = ArticleCategory.all
    @areas = Area.get_by_level(2)
    @products = Product.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /articles/1/edit
  def edit
    # authorize
    authorize! :update, @article
    
    @article_categories = ArticleCategory.all
    @areas = Area.get_by_level(2)
    @products = Product.paginate(:page => params[:page], :per_page => 10)
  end

  # POST /articles
  # POST /articles.json
  def create
    @areas = Area.get_by_level(2)
    # authorize
    authorize! :create, Article
    @article = Article.new(article_params)
    
    @article.user_id = current_user.id
    
    @article.article_categories.clear
    
    # update areas
    @article.areas.clear
    if params[:area_ids].present?
        @article.areas.clear
        params[:area_ids].each do |id|      
          @article.areas << Area.find(id)
        end
    end
    
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
        format.html { redirect_to edit_admin_article_path(@article.id), notice: 'Tạo mới bài viết thành công.' }
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
    @areas = Area.get_by_level(2)
    @article_categories = ArticleCategory.all
    @products = Product.paginate(:page => params[:page], :per_page => 10)
    # authorize
    authorize! :update, @article
    
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
    
    # update areas
    @article.areas.clear
    if params[:area_ids].present?
        @article.areas.clear
        params[:area_ids].each do |id|      
          @article.areas << Area.find(id)
        end
    end

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to edit_admin_article_path(@article.id), notice: 'Chỉnh sửa bài viết thành công.' }
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
    # authorize
    authorize! :delete, @article
    
    @article.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_url, notice: 'Xóa bài viết thành công.' }
      format.json { head :no_content }
    end
  end
  
  def approve
    @article = Article.find(params[:id])
    authorize! :approve, @article
    @article.approved = true
    @article.save
    respond_to do |format|
      format.html { redirect_to admin_articles_url, notice: 'Duyệt bài viết thành công.' }
      format.json { head :no_content }
    end
  end
  
  def upload_image_video
    `mkdir public/uploads/editor`    
    uploaded_io = params[:upload_file]
    file_name = Time.now.getutc.to_i.to_s+"."+uploaded_io.original_filename.split(".").last
    path = Rails.root.join('public', 'uploads', 'editor', file_name)
    public_path = '/uploads/editor/'+file_name
    
    # check image
    images = ['image/png', 'image/jpeg', 'image/jpg', 'image/gif']
    if images.include?(uploaded_io.content_type)
      File.open(path, 'wb') do |file|
        file.write(uploaded_io.read)
      end
      
      render text: "<script>parent.editor_uploaded('<img src=\""+public_path.to_s+"\" />')</script>"
    end
    
    # check video
    videos = ['video/x-flv', 'video/mp4', 'application/x-mpegURL', 'video/MP2T', 'video/3gpp', 'video/quicktime', 'video/x-msvideo', 'video/x-ms-wmv']
    if videos.include?(uploaded_io.content_type)
      File.open(path, 'wb') do |file|
        file.write(uploaded_io.read)
      end
      
      if params[:image].present?
        image_io = params[:image]
        image_name = Time.now.getutc.to_i.to_s+"-thumb."+image_io.original_filename.split(".").last
        image_path = Rails.root.join('public', 'uploads', 'editor', image_name)
        File.open(image_path, 'wb') do |f|
          f.write(image_io.read)
        end
        image_public_path = '/uploads/editor/'+image_name
      end
      
      video_tag = "<img thumb=\"#{image_public_path.to_s}\" width=\"100%\" height=\"100%\" class=\"video_map\" rel=\"#{public_path.to_s}\" src=\"/img/videobg.png\" />"
      render text: "<script>parent.editor_uploaded('"+video_tag+"')</script>"
    end
  end
  
  def add_related_products
    if params[:product_ids].present?
      @products = Product.where(id: params[:product_ids].split(","))
      render "/admin/articles/_table_related_products", layout: nil
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:image_url, :title, :content, :tags, :meta_keywords, :meta_description, :article_category_id, :code, :code_status_id, :is_show, :page_layout, :image_url_full_width, :area_id)
    end
end
