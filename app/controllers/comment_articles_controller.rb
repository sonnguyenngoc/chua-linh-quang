class CommentArticlesController < ApplicationController
  before_action :set_comment_article, only: [:destroy]
  
  def verify_google_recaptcha(secret_key,response)
    status = `curl "https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{response}"`
    logger.info "---------------status ==> #{status}"
    hash = JSON.parse(status)
    hash["success"] == true ? true : false
  end

  # POST /comment_articles
  # POST /comment_articles.json
  def create
    @comment_article = CommentArticle.new(comment_article_params)
    @secret_key = "6Le7mh8TAAAAAGKRPjxYnO9t0O1_m8dgxa-EgcOB"
    @comment_article.user_id = current_user.id if current_user.present?
    @comment_article.parent_id = params[:parent_id] if params[:parent_id].present?
    
    status = verify_google_recaptcha(@secret_key, params["g-recaptcha-response"])
    respond_to do |format|
      if @comment_article.save
        format.html { redirect_to controller: "blog", action: "show", blog_id: @comment_article.article_id }
      else
        flash[:notice] = "Đăng bình luận không thành công"
        format.html { redirect_to controller: "blog", action: "show", blog_id: @comment_article.article_id }
      end
    end
  end
  
  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment_article.destroy
    respond_to do |format|
      format.html { redirect_to controller: "blog", action: "show", blog_id: @comment_article.article_id }
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
      params.require(:comment_article).permit(:name, :email, :content, :user_id, :article_id, :parent_id)
    end
end
