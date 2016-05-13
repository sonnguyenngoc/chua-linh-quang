class CommentArticlesController < ApplicationController
  before_action :set_comment_article, only: [:show, :edit, :update, :destroy]

  # GET /comment_articles
  # GET /comment_articles.json
  def index
    @comment_articles = CommentArticle.all
  end

  # GET /comment_articles/1
  # GET /comment_articles/1.json
  def show
  end

  # GET /comment_articles/new
  def new
    @comment_article = CommentArticle.new
  end

  # GET /comment_articles/1/edit
  def edit
  end
  
  def verify_google_recaptcha(secret_key,response)
    status = `curl "https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{response}"`
    logger.info "---------------status ==> #{status}"
    hash = JSON.parse(status)
    hash["success"] == true ? true : false
  end

  # POST /comment_articles
  # POST /comment_articles.json
  def create
    @secret_key = "6Le7mh8TAAAAAGKRPjxYnO9t0O1_m8dgxa-EgcOB"
    @comment_article = CommentArticle.new(comment_article_params)
  
    status = verify_google_recaptcha(@secret_key, params["g-recaptcha-response"])
    respond_to do |format|
      if @comment_article.save && status
        format.html { redirect_to controller: "blog", action: "show", blog_id: @comment_article.article_id }
      else
        flash[:notice] = "Đăng bình luận thất bại"
        format.html { redirect_to controller: "blog", action: "show", blog_id: @comment_article.article_id }
      end
    end
  end

  # PATCH/PUT /comment_articles/1
  # PATCH/PUT /comment_articles/1.json
  def update
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
    @comment_article.destroy
    respond_to do |format|
      format.html { redirect_to comment_articles_url, notice: 'Comment article was successfully destroyed.' }
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
