class BlogController < ApplicationController
  def index
    @title_head = "Danh sách bài viết"
    @blogs = Article.get_all_blogs.paginate(:page => params[:page], :per_page => 3)
  end
  
  def show
    @blog = Article.find(params[:blog_id])
    @comment = CommentArticle.new
    @title_head = @blog.title
    @META_KEYWORDS = @blog.meta_keywords
    @META_DESCRIPTION = @blog.meta_description
    
    session[:user_return_to] = show_path(@blog)+"#form_comment_box"
    
    if @blog.page_layout == "full_width"
      @related_products = @blog.products.search(params).paginate(:page => params[:page], :per_page => 12)
      render "blog/deal"
    end
  end
  
  def article_category
    @article_category = ArticleCategory.find(params[:article_category_id])
    @blogs = @article_category.get_blogs_for_categories(params).paginate(:page => params[:page], :per_page => 3)
    @title_head = @article_category.name
    @META_KEYWORDS = @article_category.meta_keywords
    @META_DESCRIPTION = @article_category.meta_description
  end
  
  #def deal
  #  @products = Product.all.paginate(:page => params[:page], :per_page => 12)
  #end
end
