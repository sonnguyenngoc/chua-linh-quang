class Admin::CommentArticlesController < ApplicationController
  before_action :set_comment_article, only: [:show, :edit, :update, :destroy]

  # GET /comment_articles
  # GET /comment_articles.json
  def index
    # authorize
    authorize! :read, CommentArticle
    
    @comment_articles = CommentArticle.search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    # authorize
    authorize! :read, CommentArticle
    
    @comment_articles = CommentArticle.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/comment_articles/index"
  end

  # GET /comment_articles/1
  # GET /comment_articles/1.json
  def show
  end

  # GET /comment_articles/new
  def new
    # authorize
    authorize! :create, CommentArticle
    
    @comment_article = CommentArticle.new
  end

  # GET /comment_articles/1/edit
  def edit
    # authorize
    authorize! :update, CommentArticle
  end

  # POST /comment_articles
  # POST /comment_articles.json
  def create
    # authorize
    authorize! :create, CommentArticle
    
    @comment_article = CommentArticle.new(comment_article_params)

    respond_to do |format|
      if @comment_article.save
        format.html { redirect_to controller: "blog", action: "show", blog_id: @comment_article.article_id }
        format.json { render :show, status: :created, location: @comment_article }
      else
        format.html { render :new }
        format.json { render json: @comment_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comment_articles/1
  # PATCH/PUT /comment_articles/1.json
  def update
    # authorize
    authorize! :update, CommentArticle
    
    respond_to do |format|
      if @comment_article.update(comment_article_params)
        format.html { redirect_to @comment_article, notice: 'Comment article was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment_article }
      else
        format.html { render :edit }
        format.json { render json: @comment_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comment_articles/1
  # DELETE /comment_articles/1.json
  def destroy
    # authorize
    authorize! :delete, CommentArticle
    
    @comment_article.destroy
    respond_to do |format|
      format.html { redirect_to admin_comment_articles_url, notice: 'Comment article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment_article
      @comment_article = CommentArticle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_article_params
      params.require(:comment_article).permit(:name, :email, :content, :user_id, :article_id)
    end
end
