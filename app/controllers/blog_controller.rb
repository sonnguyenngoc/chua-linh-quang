class BlogController < ApplicationController
  def index
    @title_head = "Danh sách bài viết"
    @blogs = Article.get_all_blogs.paginate(:page => params[:page], :per_page => 3)
  end
  
  def show
    @title_head = "Chi tiết bài viết"
    @blog = Article.find(params[:blog_id])
    @comment = CommentArticle.new
  end
  
  def article_category
    @title_head = "Chuyên mục bài viết"
    @article_category = ArticleCategory.find(params[:article_category_id])
    @blogs = @article_category.get_blogs_for_categories(params).paginate(:page => params[:page], :per_page => 3)
  end
end
